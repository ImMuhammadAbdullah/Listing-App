//
//  ApiClient.swift
//  Assesment
//
//  Created by Dev on 25/03/2024.
//

import Foundation
import Combine

protocol ApiClient {
    func request<T: Decodable>(_ endpoint: Endpoint, of type: T.Type) -> AnyPublisher<T,Error>
}
