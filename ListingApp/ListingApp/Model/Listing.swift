//
//  Listing.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Foundation

// MARK: - Listing Model
struct Listing: Identifiable, Decodable {
    let id: String // maps to "uid"
    let name: String
    let price: String
    let createdAt: String
    let imageUrls: [String]
    let imageUrlsThumbnails: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case name
        case price
        case createdAt = "created_at"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
    }
}

// MARK: - Listings Response
struct ListingsResponse: Decodable {
    let results: [Listing]
    let pagination: Pagination?
}

struct Pagination: Decodable {
    let key: String?
}
