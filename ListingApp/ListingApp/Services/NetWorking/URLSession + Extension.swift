//
//  URLSession + Extension.swift
//  Assesment
//
//  Created by Dev on 25/03/2024.
//

import Foundation
import Combine

extension URLSession: ApiClient{
    func request<T>(_ endpoint: Endpoint, of type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        let urlString = "\(endpoint.baseURL)\(endpoint.path)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError.badURL as! Error).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        
        let output = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return output
    }
}
