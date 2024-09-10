//
//  HomeView.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import SwiftUI

struct ListingsView: View {
    @StateObject var viewModel = ListingViewModel(client: URLSession.shared)
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    loadingView
                } else {
                    listingsListView
                }
            }
            .navigationTitle("Listings")
            .task {
                viewModel.fetchListings()
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5, anchor: .center)
    }
    
    private var listingsListView: some View {
        List(viewModel.listings) { listing in
            NavigationLink(destination: ListingDetailView(listing: listing)) {
                listingRowView(for: listing)
            }
        }
    }
    
    private func listingRowView(for listing: Listing) -> some View {
        HStack {
            listingThumbnailView(for: listing)
            listingDetailsView(name: listing.name, price: listing.price)
        }
    }
    
    private func listingThumbnailView(for listing: Listing) -> some View {
        if let url = viewModel.thumbnailURL(for: listing) {
            return AnyView(
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            )
        } else {
            return AnyView(
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
            )
        }
    }
    
    private func listingDetailsView(name: String, price: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
            Text(price)
                .foregroundColor(.gray)
        }
        .padding(.leading, 8)
    }
}

#Preview {
    ListingsView()
}

