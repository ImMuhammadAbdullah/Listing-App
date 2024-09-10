//
//  Endpoint.swift
//  Assesment
//
//  Created by Dev on 25/03/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case PUT = "PUT"
    case Delete = "DELETE"
}

protocol Endpoint {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    // header
    // query parameters
}

