//
//  PokemonListViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import Foundation

final class PokemonListViewModel: ObservableObject {
    
    @Published var pokeList: [Pokemon] = []
    @Published var textSearching: String = ""
    
    var fetchList: [Pokemon] = []
    var filterList: [Pokemon] = []
    
    private var service: PokemonService
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func fetchPokemons() {
        service.getPokeItemList(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pokemon):
                let list = pokemon.sorted { $0.id < $1.id }
                self.fetchList = list
                DispatchQueue.main.async {
                    self.pokeList = self.textSearching.isEmpty ? self.fetchList : self.filterList
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
}
