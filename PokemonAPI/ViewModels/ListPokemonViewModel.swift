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
    @Published var filterBy: FilterTabItem = .name
    @Published var textSearching: String = ""
    @Published var invalidSearch: Bool = false
    @Published var connectivity: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private var fetchList: [PokemonViewModel] = []
    
    private let service: Service
    
    private var urlPokelist: URL {
        Endpoint.getPokeList.url(baseURL: baseURL)
    }
    
    init(service: Service) {
        self.service = service
        getPokemonsList(url: urlPokelist)
        searchByFilter()
        setInitialValues()
    }
    
    private func getPokemonsList(url: URL) {
        isLoading = true
        service
            .getPokemonList(url: url)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure = completion {
                    self?.invalidSearch = true
                    // MARK: TO-DO
                    // Show error when don't have any pokemon in localDB and it was a failure on the request
                    print("failure request")
                }
            } receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                let sortedPokemons = pokemons.sorted(by: { $0.id < $1.id }).map { PokemonViewModel($0) }
                if self.fetchList.isEmpty {
                    self.fetchList = sortedPokemons
                }
                self.setValues(list: sortedPokemons)
            }
            .store(in: &cancellables)
    }
    
    private func getPokemon(url: URL) {
        service
            .getPokemons(url: url)
            .handleEvents(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    guard let self = self else { return }
//                    return self.getLocalPokemons()
                }
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure = completion {
                    self?.invalidSearch = true
                    print("failure request")
                }
            } receiveValue: { [weak self] pokemon in
                self?.setValues(list: [PokemonViewModel(pokemon)])
            }.store(in: &cancellables)
    }
    
    private func searchByFilter() {
        self.isLoading = true
        $textSearching
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                let url = self.filterBy.getURLByFilter(searchText: searchText)
                if self.filterBy == .name {
                    self.getPokemon(url: url)
                } else {
                    self.getPokemonsList(url: url)
                }
            }
            .store(in: &cancellables)
    }
    
//    private func getLocalPokemons() {
//        useCaseLocalDB.getPokemonsFromLocal { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(pokemons):
//                let sortedPokemons = pokemons.sorted(by: { $0.id < $1.id }).map { PokemonViewModel($0) }
//                if self.fetchList.isEmpty {
//                    self.fetchList = sortedPokemons
//                }
//                self.setValues(list: sortedPokemons)
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    private func setInitialValues() {
        $textSearching
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.setValues(list: self.fetchList)
            }
            .store(in: &cancellables)
    }
    
    
    private func setValues(list: [PokemonViewModel]) {
        self.pokeList = list
        self.isLoading = false
        self.invalidSearch = false
    }

}
