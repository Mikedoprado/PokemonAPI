//
//  HTTPClientSpy.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation
@testable import PokemonAPI

class HTTPClientSpy: HTTPClient {

    private class Task: HTTPClientTask {
        func cancel() {}
    }
    
    private var message = [(url: URL, completion: (Result) -> Void)]()
    
    var requestedURLs: [URL] {
        message.map { $0.url }
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> PokemonAPI.HTTPClientTask {
        message.append((url, completion))
        return Task()
    }
    
    func complete(with error: Error, at index: Int = 0) {
        message[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil)!
        message[index].completion(.success((data, response)))
    }
}
