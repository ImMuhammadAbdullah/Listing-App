//
//  ListingsViewModel.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import Foundation
import Combine

class ListingViewModel: ObservableObject {
    // Can add pagination on the listing if needed in the future
    @Published var listings: [Listing] = []
    @Published var isLoading: Bool = false

    private let client: ApiClient
    private var cancellables = Set<AnyCancellable>()
    
    init(client: ApiClient) {
        self.client = client
    }
    
    func fetchListings(pullToRefresh: Bool = false) {
        if !pullToRefresh && !listings.isEmpty {
            return
        }
        
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
                    // Optionally handle error (e.g., show an alert)
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
