//
//  ListingDetailViewModel.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Foundation
import Combine

class ListingDetailViewModel: ObservableObject {
    var listing: Listing
    
    init(listing: Listing) {
        self.listing = listing
    }
    
    var formattedPrice: String {
        return "Price: \(listing.price)"
    }
    
    var creationDate: String {
        return "Created At: \(listing.createdAt)"
    }
    
    var firstImageURL: URL? {
        return URL(string: listing.imageUrls.first ?? "")
    }
}
