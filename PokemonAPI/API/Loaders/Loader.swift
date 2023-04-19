//
//  Loader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

final class Loader<Resource> {
    private let client: HTTPClient
    private let mapper: Mapper

    init(client: HTTPClient, mapper: @escaping Mapper) {
        self.client = client
        self.mapper = mapper
    }
    
    typealias Result = Swift.Result<Resource, Swift.Error>
    typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    func load(url: URL, completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, response)):
                completion(self.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            return .success(try mapper(data, response))
        } catch {
            return .failure(Error.invalidData)
        }
    }
}
