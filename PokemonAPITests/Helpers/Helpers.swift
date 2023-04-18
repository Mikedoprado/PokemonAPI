//
//  Helpers.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "error", code: 0)
}

func anyData() -> Data {
    return Data("anyData".utf8)
}
