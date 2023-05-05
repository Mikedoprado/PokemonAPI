//
//  CombineHelpers.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 4/05/23.
//

import Combine
import Foundation

extension HTTPClient {
    typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
    
    func getPublisher(url: URL) -> Publisher {
        var task: HTTPClientTask?
        
        return Deferred {
            Future { completion in
                task = self.get(from: url, completion: completion)
            }
        }
        .handleEvents(receiveCancel: { task?.cancel() } )
        .eraseToAnyPublisher()
    }
}
