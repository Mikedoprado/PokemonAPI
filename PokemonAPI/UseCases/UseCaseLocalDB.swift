//
//  UseCaseLocalDB.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 23/04/23.
//

final class UseCaseLocalDB {

    private var service: FetchingPokemonProtocol
    
    init(service: FetchingPokemonProtocol) {
        self.service = service
    }
    
    func getPokemonsFromLocal(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        service.getPokemonsFromLocal(completion: completion)
    }
}
