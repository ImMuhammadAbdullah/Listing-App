//
//  MockApiClient.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Combine
import Foundation

class MockApiClient: ApiClient {
    var fetchListingsResult: Result<ListingsResponse, Error>?
    
    func request<T: Decodable>(_ endpoint: Endpoint, of type: T.Type) -> AnyPublisher<T, Error> {
        guard let result = fetchListingsResult else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        
        switch result {
        case .success(let response):
            guard let typedResponse = response as? T else {
                return Fail(error: URLError(.cannotDecodeContentData)).eraseToAnyPublisher()
            }
            return Just(typedResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}


