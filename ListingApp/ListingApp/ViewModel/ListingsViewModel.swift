//
//  ListingsViewModel.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Foundation
import Combine

@Observable
class ListingViewModel: ObservableObject {
    // Can add pagination on the listing if needed in the future
    var listings: [Listing] = []
    var isLoading: Bool = false

    private let client: ApiClient
    private var cancellables = Set<AnyCancellable>()
    
    init(client: ApiClient) {
        self.client = client
    }
    
    func fetchListings() {
        if listings.count > 0 { return }
        isLoading = true
        client.request(ListingsEndpoint.fetchListings, of: ListingsResponse.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    print("ERROR: \(error)")
                    // Throw error to user if needed
                }
            } receiveValue: { [weak self] response in
                self?.listings = response.results
            }
            .store(in: &cancellables)
    }
    
    func thumbnailURL(for listing: Listing) -> URL? {
        return URL(string: listing.imageUrlsThumbnails.first ?? "" )
    }
}
