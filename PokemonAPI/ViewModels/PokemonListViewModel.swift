//
//  PokemonListViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import Foundation

final class PokemonListViewModel: ObservableObject {
    
    @Published var pokeList: [Pokemon] = []
    private var service: PokemonService
    
    init(service: PokemonService) {
        self.service = service
    }
    
    func fetchPokemons() {
        service.getPokeItemList(completion: { [weak self] result in
            
            switch result {
            case let .success(pokemon):
                let list = pokemon.sorted { $0.id < $1.id }
                DispatchQueue.main.async {
                    self?.pokeList = list
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
}
