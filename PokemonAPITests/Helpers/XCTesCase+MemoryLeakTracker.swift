//
//  XCTesCase+MemoryLeakTracker.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak",
                file: file,
                line: line)
        }
    }
}
