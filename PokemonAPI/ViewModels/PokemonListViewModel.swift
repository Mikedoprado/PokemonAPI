//
//  PokemonListViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import Foundation
import Combine

final class PokemonListViewModel: ObservableObject {
    
    @Published var pokeList: [Pokemon] = []
    @Published var textSearching: String = ""
    @Published var isLoading: Bool = false
    @Published var invalidSearch: Bool = false
    @Published var connectivity: Bool = true
    @Published var filterBy: TabBarItem = .name
    
    private var cancellables = Set<AnyCancellable>()
    private var fetchList: [Pokemon] = []
    private var service: FetchingPokemonProtocol
    
    private var searchCriteria: TabBarItem { filterBy }
    
    private var urlPokelist: URL {
        Endpoint.getPokeList.url(baseURL: baseURL)
    }

    init(service: FetchingPokemonProtocol) {
        self.service = service
        searchingByNameOrAbility()
        setInitialValues()
        fetchPokemons(url: urlPokelist)
    }

    private func fetchPokemons(url: URL) {
        isLoading = true
        service.getPokeItemList(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            self.mapResult(result: result) { pokemons in
                let list = pokemons.sorted { $0.id < $1.id }
                if self.textSearching.isEmpty {
                    self.fetchList = list
                }
                self.setValues(list: list)
            }
        })
    }
    
    private func setInitialValues() {
        $textSearching
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.setValues(list: self.fetchList)
            }
            .store(in: &cancellables)
    }
    
    private func searchingByNameOrAbility() {
        $textSearching
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                switch self?.searchCriteria {
                case .name:
                    let urlString = Endpoint.getPokemonByName(searchText.lowercased()).url(baseURL: baseURL).absoluteString
                    self?.searchPokemon(urlString: urlString)
                case .ability:
                    let url = Endpoint.getPokemonByAbility(searchText.lowercased()).url(baseURL: baseURL)
                    self?.fetchPokemons(url: url)
                default:
                    let urlString = Endpoint.getPokemonByName(searchText.lowercased()).url(baseURL: baseURL).absoluteString
                    self?.searchPokemon(urlString: urlString)
                }
            }
            .store(in: &cancellables)
    }

    private func searchPokemon(urlString: String) {
        service.getPokemonList(pokemonURLs: [urlString]) { [weak self] result in
            self?.mapResult(result: result) { pokemons in
                self?.setValues(list: pokemons)
            }
        }
    }
    
    private func setValues(list: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokeList = list
            self.isLoading = false
            self.invalidSearch = false
        }
    }
    
    private func getPokemonsFromLocal() {
        service.getPokemonsFromLocal { [weak self] result in
            guard let self = self else { return }
            self.mapResult(result: result) { pokemons in
                let list = pokemons.sorted { $0.id < $1.id }
                self.fetchList = list
                DispatchQueue.main.async {
                    self.pokeList = list
                    self.isLoading = false
                    self.connectivity = false
                }
            }
        }
    }
    
    private func mapResult(result: Result<[Pokemon], Error>, action: ([Pokemon]) -> Void) {
        switch result {
        case let .success(pokemons):
            action(pokemons)
        case let .failure(error):
            parsingError(error: error)
        }
    }
    
    private func parsingError(error: Error) {
        typealias LoaderPokemonError = Loader<Pokemon>.Error
        typealias LoaderPokeItemError = Loader<[PokeItem]>.Error
        if error as? LoaderPokemonError == .invalidData || error as? LoaderPokeItemError == .invalidData {
            DispatchQueue.main.async { [weak self] in
                self?.invalidSearch = true
            }
        } else if error as? LoaderPokemonError == .connectivity || error as? LoaderPokeItemError == .connectivity {
            self.getPokemonsFromLocal()
        }
    }
    
}
