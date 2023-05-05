//
//  ListPokemonViewModelFactory.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 23/04/23.
//
import Foundation

final class ListPokemonViewModelFactory {
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    private lazy var service = Service(httpClient: httpClient)
    
    func makeViewModel() -> ListPokemonViewModel {
        ListPokemonViewModel(service: service)
    }
}
