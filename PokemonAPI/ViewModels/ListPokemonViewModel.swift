//
//  ListPokemonViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 23/04/23.
//

import Foundation
import Combine

final class ListPokemonViewModel: ObservableObject {
    @Published var pokeList: [PokemonViewModel] = []
    @Published var isLoading: Bool = false
    @Published var filterBy: TabBarItem = .name
    @Published var textSearching: String = ""
    @Published var invalidSearch: Bool = false
    @Published var connectivity: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private var fetchList: [PokemonViewModel] = []
    
    let useCaseSearch: UseCaseSearchPokemon
    let useCaseLocalDB: UseCaseLocalDB
    
    private var urlPokelist: URL {
        Endpoint.getPokeList.url(baseURL: baseURL)
    }
    
    init(
        useCaseSearch: UseCaseSearchPokemon,
        useCaseLocalDB: UseCaseLocalDB
    ) {
        self.useCaseSearch = useCaseSearch
        self.useCaseLocalDB = useCaseLocalDB
        fetchPokemons()
        searching()
        getPokemonFromLocal()
        setInitialValues()
        
    }
    
    private func fetchPokemons() {
        useCaseSearch.getPokemons(url: urlPokelist) { [weak self] result in
            guard let self = self else { return }
            self.mapResult(result: result, action: { pokemons in
                self.fetchList = pokemons
                self.setValues(list: pokemons)
            })
        }
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
    
    private func searching() {
        self.isLoading = true
        $textSearching
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.useCaseSearch.searchingByFilter(
                    searchText: searchText,
                    filterBy: self.filterBy,
                    completion: { result in
                        self.mapResult(result: result, action: { pokemons in
                            self.setValues(list: pokemons)
                        })
                    })
            }.store(in: &cancellables)
    }
    
    private func setValues(list: [PokemonViewModel]) {
        DispatchQueue.main.async {
            self.pokeList = list
            self.isLoading = false
            self.invalidSearch = false
        }
    }
    
    private func getPokemonFromLocal() {
        $connectivity
            .filter { !$0 }
            .sink { [weak self] _ in
                self?.useCaseLocalDB.getPokemonsFromLocal { [weak self] result in
                    self?.mapResult(result: result, action: { pokemons in
                        self?.fetchList = pokemons
                        self?.setValues(list: pokemons)
                    })
                }
            }.store(in: &cancellables)
    }
    
    private func mapResult(result: Result<[Pokemon], Error>, action: ([PokemonViewModel]) -> Void) {
        switch result {
        case let .success(pokemons):
            action(pokemons.map { PokemonViewModel($0) }.sorted { $0.id < $1.id })
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
                self?.isLoading = false
            }
        } else if error as? LoaderPokemonError == .connectivity || error as? LoaderPokeItemError == .connectivity {
            self.getPokemonFromLocal()
            self.connectivity = false
        }
    }
    
}
