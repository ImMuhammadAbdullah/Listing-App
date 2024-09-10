//
//  ListingDetailView.swift
//  ListingApp
//
//  Created by Dev on 10/09/2024.
//

import SwiftUI

struct ListingDetailView: View {
    let listing: Listing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(listing.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(listing.price)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text("Created At: \(listing.createdAt)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if !listing.imageUrls.isEmpty {
                    AsyncImage(url: URL(string: listing.imageUrls.first!)) { image in
                        image.resizable()
                             .scaledToFit()
                             .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Listing Details")
    }
}


#Preview {
    ListingDetailView(listing: Listing(id: "1", name: "Sample Listing", price: "$100", createdAt: "2024-09-10", imageUrls: ["https://via.placeholder.com/150"], imageUrlsThumbnails: ["https://via.placeholder.com/50"]))
}
