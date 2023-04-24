//
//  ListPokemonViewModelFactory.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 23/04/23.
//

final class ListPokemonViewModelFactory {
    private lazy var service = FactoryPokemonService().makePokemonService()
    private lazy var useCaseSearch = UseCaseSearchPokemon(service: service)
    private lazy var useCaseLocalDB = UseCaseLocalDB(service: service)
    
    func makeViewModel() -> ListPokemonViewModel {
        ListPokemonViewModel(
            useCaseSearch: useCaseSearch,
            useCaseLocalDB: useCaseLocalDB)
    }
}
