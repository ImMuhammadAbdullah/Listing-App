//
//  ListingViewModelTests.swift
//  ListingAppTests
//
//  Created by Dev on 10/09/2024.
//

import XCTest
import Combine
@testable import ListingApp

class ListingViewModelTests: XCTestCase {
    var viewModel: ListingViewModel!
    var mockApiClient: MockApiClient!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockApiClient = MockApiClient()
        viewModel = ListingViewModel(client: mockApiClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockApiClient = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchListingsSuccess() {
        // Given
        let expectedListings = [
            Listing(id: "1", name: "Item 1", price: "10.0", createdAt: "2024-09-10T12:00:00Z", imageUrls: [], imageUrlsThumbnails: ["https://example.com/thumb1.jpg"]),
            Listing(id: "2", name: "Item 2", price: "20.0", createdAt: "2024-09-09T12:00:00Z", imageUrls: [], imageUrlsThumbnails: ["https://example.com/thumb2.jpg"])
        ]
        let response = ListingsResponse(results: expectedListings, pagination: nil)
        mockApiClient.fetchListingsResult = .success(response)
        
        // When
        viewModel.fetchListings()
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
        
        let expectation = XCTestExpectation(description: "Wait for fetchListings to complete")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.listings.count, expectedListings.count)
            XCTAssertEqual(self.viewModel.listings.first?.id, expectedListings.first?.id)
            XCTAssertEqual(self.viewModel.listings.first?.price, expectedListings.first?.price)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchListingsFailure() {
        // Given
        mockApiClient.fetchListingsResult = .failure(URLError(.badServerResponse))
        
        // When
        viewModel.fetchListings()
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
        
        let expectation = XCTestExpectation(description: "Wait for fetchListings to complete")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.listings.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
