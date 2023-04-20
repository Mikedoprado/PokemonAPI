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
    private var cancellables = Set<AnyCancellable>()
    private var fetchList: [Pokemon] = []
    private var service: FetchingPokemonProtocol
    
    private var urlPokelist: URL {
        Endpoint.getPokeList.url(baseURL: baseURL)
    }

    init(service: FetchingPokemonProtocol) {
        self.service = service
        searchingByText()
        setInitialValues()
        fetchPokemons(url: urlPokelist)
    }
    
    private func setInitialValues() {
        $textSearching
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.pokeList = self.fetchList
            }
            .store(in: &cancellables)
    }
    
    private func searchingByText() {
        $textSearching
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                let urlString = Endpoint.getPokemonByName(searchText.lowercased()).url(baseURL: baseURL).absoluteString
                self?.searchPokemon(urlString: urlString)
            }
            .store(in: &cancellables)
    }
    
    private func fetchPokemons(url: URL) {
        isLoading = true
        service.getPokeItemList(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            self.mapResult(result: result) { pokemons in
                let list = pokemons.sorted { $0.id < $1.id }
                self.fetchList = list
                DispatchQueue.main.async {
                    self.pokeList = self.fetchList
                    self.isLoading = false
                }
            }
        })
    }
    
    private func searchPokemon(urlString: String) {
        isLoading = true
        service.getPokemonList(pokemonURLs: [urlString]) { [weak self] result in
            self?.mapResult(result: result) { pokemons in
                DispatchQueue.main.async {
                    self?.pokeList = pokemons
                    self?.isLoading = false
                }
            }
        }
    }
    
    private func mapResult(result: Result<[Pokemon], Error>, action: ([Pokemon]) -> Void) {
        switch result {
        case let .success(pokemons):
            action(pokemons)
        case let .failure(error):
            print(error)
        }
    }
    
}
