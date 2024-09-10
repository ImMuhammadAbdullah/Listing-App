//
//  ListingEndpoint.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Foundation

enum ListingsEndpoint: Endpoint {
    case fetchListings
    
    var baseURL: String {
        return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
    }
    
    var path: String {
        switch self {
        case .fetchListings:
            return "/default/dynamodb-writer"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchListings:
            return .get
        }
    }
}
