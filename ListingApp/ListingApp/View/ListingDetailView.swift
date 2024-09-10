//
//  ListingDetailView.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import SwiftUI

struct ListingDetailView: View {
    @StateObject private var viewModel: ListingDetailViewModel
    
    init(listing: Listing) {
        _viewModel = StateObject(wrappedValue: ListingDetailViewModel(listing: listing))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                titleView
                priceView
                creationDateView
                imageView
            }
            .padding()
        }
        .navigationTitle("Listing Details")
    }
    
    private var titleView: some View {
        Text(viewModel.listing.name)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    private var priceView: some View {
        Text(viewModel.formattedPrice)
            .font(.title3)
            .foregroundColor(.gray)
    }
    
    private var creationDateView: some View {
        Text(viewModel.creationDate)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
    
    private var imageView: some View {
        Group {
            if let url = viewModel.firstImageURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(height: 200)
                         .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
            } else {
                EmptyView()
            }
        }
    }
}

#Preview {
    ListingDetailView(listing: Listing(id: "1", name: "Sample Listing", price: "$100", createdAt: "2024-09-10", imageUrls: ["https://via.placeholder.com/150"], imageUrlsThumbnails: ["https://via.placeholder.com/50"]))
}
