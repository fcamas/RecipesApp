# TakeHomeProjectRecipes

A SwiftUI app for browsing recipes with images, caching, and error handling.

## Features

✅ **Fetch Recipes:**
- Supports three endpoints: All Recipes, Malformed Recipes, and Empty Recipes.
- Uses URLSession to fetch and decode JSON data.

✅ **Caching:**
- Memory caching with NSCache.
- Disk caching for images using the app's Caches directory.

✅ **Recipe Display:**
- Grid-based UI with adaptive columns.
- Displays recipe name, cuisine, and YouTube link (if available).

✅ **Error Handling:**
- Handles invalid URLs, decoding failures, and empty recipe lists.

## Screenshots

![App Screenshot](screenshot1.png)

## Installation

1. Clone the repository.
2. Open the Xcode project.
3. Run the app on a simulator or device.

## Technologies

- SwiftUI
- Combine
- URLSession
- NSCache
- Disk Caching
- CryptoKit (MD5 hashing for image caching)

## API Endpoints

- All Recipes: `https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json`
- Malformed Recipes: `https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json`
- Empty Recipes: `https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json`

## Usage

1. Select a tab to view recipes.
2. Pull to refresh and fetch the latest data.
3. Tap on a YouTube icon to watch the recipe video.
