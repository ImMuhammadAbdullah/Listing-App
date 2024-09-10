# Listing-App

## Overview

Listing-App is a SwiftUI-based iOS application that provides a clean interface for browsing and viewing product listings. The app features a home screen displaying a list of items, each leading to a detailed view upon selection.

## Features

- **Homepage View:** Presents a list of product listings with thumbnails, names, and prices.
- **Detail View:** Provides in-depth information about a selected listing, including a larger image, title, price, and creation date.
- **Loading State:** Displays a progress indicator while data is being fetched.

## Screenshots

**Homepage View:**

![Listing](https://github.com/user-attachments/assets/49333b93-b30f-4fbc-b7b4-4fb0036035eb)

**Detail View:**

![ListingDetail](https://github.com/user-attachments/assets/17e65fe0-f077-4596-9c7a-71db182e5b8b)

## Architecture

The app follows the **MVVM** (Model-View-ViewModel) architecture, making use of **SwiftUI** for the user interface and **Combine** for reactive programming. The architecture ensures a clean separation of concerns:

- **Model:** Contains data structures and decoding logic for listings.
- **View:** SwiftUI views for presenting the listings and their details.
- **ViewModel:** Manages data fetching, state, and business logic, bridging the Model and View.

## Key Components

- **HomeView.swift:**
  - Displays a list of listings.
  - Uses `ListingViewModel` to manage the data and state.
  - Supports navigation to the detail view of each listing.

- **ListingDetailView.swift:**
  - Shows detailed information about a selected listing.
  - Uses `ListingDetailViewModel` to handle the listing data and formatting.

- **URLSession+Extension.swift:**
  - Extends `URLSession` to support API requests with Combine.
  - Handles network requests and response parsing.

- **Listing.swift:**
  - Defines the `Listing` model and the response format for listings.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ImMuhammadAbdullah/Listing-App.git


## Dependencies

- **SwiftUI:** For building the user interface.
- **Combine:** For reactive programming and handling asynchronous data streams.

## API Usage

The app interacts with a REST API to fetch listing data. The API details are managed through the `URLSession+Extension.swift` file, which configures requests and handles responses.

## Time Spent:

2 Hours

