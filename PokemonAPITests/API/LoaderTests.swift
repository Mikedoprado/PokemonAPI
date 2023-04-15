//
//  LoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import XCTest
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
    
    func test_deliverErrorOnClientError() {
        let (sut, client) = makeSUT()
        expect(sut: sut, completeWith: .failure(Loader.Error.connectivity)) {
            let clientError = anyNSError()
            client.complete(with: clientError)
        }

    }
    
    func test_deliverErrorOnNot200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(Loader.Error.invalidData)) {
                let invalidData = makeItemsJSON([])
                client.complete(withStatusCode: code, data: invalidData, at: index)
            }
        }
    }
    
    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .failure(Loader.Error.invalidData)) {
            let invalidData = Data("invalidData".utf8)
            client.complete(withStatusCode: 200, data: invalidData)
        }
    }
    
    func test_deliverNoItemsOn200HTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .success([])) {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }
    
    // MARK: Helpers
    
    private func makeSUT(
        url: URL = URL(string: "http://any-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: Loader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = Loader(url: url, client: client)
        trackForMemoryLeak(instance: client)
        trackForMemoryLeak(instance: sut)
        return (sut, client)
    }
    
    private func expect(
        sut: Loader,
        completeWith expectedResult: Loader.Result,
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
                XCTAssertEqual(receivedError as! Loader.Error, expectedError as! Loader.Error, file: file, line: line)
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
    
    private func anyNSError() -> NSError {
        return NSError(domain: "error", code: 0)
    }
    
    private func anyData() -> Data {
        return Data("anyData".utf8)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let itemsJSON = ["items": items]
        return try! JSONSerialization.data(withJSONObject: itemsJSON)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var message = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            message.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            message.append((url, completion))
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
}
