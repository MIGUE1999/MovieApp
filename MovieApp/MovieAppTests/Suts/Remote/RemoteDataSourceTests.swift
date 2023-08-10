//
//  RemoteDataSourceTests.swift
//  MovieAppTests
//
//  Created by Tejada Ortigosa Miguel Angel on 10/8/23.
//

import XCTest
@testable import MovieApp

final class RemoteDataSourceTests: XCTestCase {
    
    // MARK: - Sut
    var sut: MovieService?

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Configuramos el mock de URLSession
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        
        // Inyectamos la configuración nuestra al mock
        let mockURLSession = URLSession.init(configuration: configuration)
        sut = MovieStore(session: mockURLSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRemoteDataSource_whenFetchMoviesWithStatusCode200_completionReturnMoviesResponse() throws {
        // GIVEN
        /*
        let expectation = XCTestExpectation(description: "200")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, tokenData)
        }
        */

    }
    
    func testRemoteDataSource_whenFetchMoviesWithStatusCode400_completionReturnError() {
        // GIVEN
        let expectation = XCTestExpectation(description: "400 ERROR")
        
        // WHEN
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        sut?.fetchMovies(from: .popular, completion: { token, error in
            
            switch error {
            case .invalidResponse:
                // THEN
                XCTAssertEqual(error?.localizedDescription, "Invalid response")
                expectation.fulfill()
            default:
                XCTFail("This request must throw 400 error")
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 1.0)
       
    }
    
}

