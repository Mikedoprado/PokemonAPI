//
//  RemoteLoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 18/04/23.
//
import XCTest
import Foundation
@testable import PokemonAPI

final class LoaderTests: XCTestCase {
    
    func test_init_doesnNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliverErrorOnClientError() {
        let (sut, client) = makeSUT()
        expect(sut: sut, completeWith: .failure(Loader<String>.Error.connectivity)) {
            let clientError = LoaderTests.anyNSError()
            client.complete(with: clientError)
        }

    }

    func test_load_deliverErrorOnMapperError() {
        let (sut, client) = makeSUT(mapper: {  _, _ in
            throw LoaderTests.anyNSError()
        })
        
        expect(sut: sut, completeWith: .failure(Loader<String>.Error.invalidData)) {
            client.complete(withStatusCode: 200, data: anyData())
        }
    }
    
    func test_load_deliversMapperResource() {
        let resource = "a resource"
        let (sut, client) = makeSUT(mapper: { data, _ in
            String(data: data, encoding: .utf8)!
        })

        expect(sut: sut, completeWith: .success(resource)) {
            client.complete(withStatusCode: 200, data: Data(resource.utf8))
        }
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstancesHasBeenDeallocated() {
        let url = anyURL()
        let client = HTTPClientSpy()
        var sut: Loader<String>? = Loader<String>(url: url, client: client, mapper: { _, _ in "any" })
        
        var capturedResults = [Loader<String>.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([:]))
        
        XCTAssertTrue(capturedResults.isEmpty)
        
    }
    
    // MARK: Helpers
    
    private func makeSUT(
        url: URL = URL(string: "http://any-url.com")!,
        mapper: @escaping Loader<String>.Mapper = { _, _ in "any" },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: Loader<String>, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = Loader<String>(url: url, client: client, mapper: mapper)
        trackForMemoryLeak(instance: client, file: file, line: line)
        trackForMemoryLeak(instance: sut, file: file, line: line)
        return (sut, client)
    }
    
    private func expect(
        sut: Loader<String>,
        completeWith expectedResult: Loader<String>.Result,
        action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "waiting for completion")
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError as! Loader<String>.Error, expectedError as! Loader<String>.Error, file: file, line: line)
            default: XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        
        wait(for: [exp], timeout: 1.0)
    }

    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private static func anyNSError() -> NSError {
        return NSError(domain: "error", code: 0)
    }
    
    private func anyData() -> Data {
        return Data("anyData".utf8)
    }
    
    private func makeItemsJSON(_ items: [String: Any]) -> Data {
        let itemsJSON = ["items": items]
        return try! JSONSerialization.data(withJSONObject: itemsJSON)
    }

}
