//
//  RecipeViewModelTests.swift
//  TakeHomeProjectRecipes
//
//  Created by Fredy on 2/17/25.
//

/*
// Test Design for RecipeViewModel
 
Test 1.1: Fetch Recipes with Valid URL
- This test should confirm that when a valid URL is passed to the fetchRecipes method, the recipes array is populated with data.
- Edge cases: Check if recipes array is empty even with a valid URL (server might return empty data).
- Expected Result: recipes array is not empty, errorMessage is nil.

Test 1.2: Fetch Recipes with Malformed URL
- This test should verify that when a malformed URL is passed, the fetchRecipes method correctly identifies the issue.
- Edge cases: The server may return an error response (e.g., 500) instead of a malformed JSON.
- Expected Result: recipes array is empty, errorMessage is not nil.

Test 1.3: Fetch Recipes with Empty URL
- This test should check that when the empty URL endpoint is used, the recipes array remains empty and an appropriate error message is shown.
- Edge cases: Server may return an empty JSON object instead of an empty array.
- Expected Result: recipes array is empty, errorMessage is "No recipes available."

Test 2.1: Image Caching
- This test should verify that images are correctly cached after the first load.
- Edge cases: Cache eviction due to memory pressure; ensure the cache still works.
- Expected Result: First image load retrieves data from network, subsequent loads retrieve from cache.
*/

import SwiftUI
import CryptoKit
import XCTest

@testable import TakeHomeProjectRecipes

// MARK: - RecipeViewModel Tests
class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!

    override func setUpWithError() throws {
        viewModel = RecipeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    // MARK: Test 1.1: Fetch Recipes with Valid URL
    func testFetchRecipesWithValidURL() async {
        let expectation = XCTestExpectation(description: "Fetch recipes successfully")

        // Perform the fetch
        await viewModel.fetchRecipes(from: .allRecipes)

        // Wait for the fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.viewModel.recipes.isEmpty, "Recipes should not be empty after a successful fetch.")
            XCTAssertNil(self.viewModel.errorMessage, "Error message should be nil after a successful fetch.")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5.0)
    }

    // MARK: Test 1.2: Fetch Recipes with Malformed URL
    func testFetchRecipesWithMalformedURL() async {
        let expectation = XCTestExpectation(description: "API fails due to malformed URL")
 
        await viewModel.fetchRecipes(from: .malformedRecipes)
       
        // Wait for the fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.recipes.isEmpty, "Recipes should be empty for a malformed URL.")
            XCTAssertNotNil(self.viewModel.errorMessage, "Error message should not be nil for a malformed URL.")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5.0)
    }

    // MARK: 1.3: Fetch Recipes with Empty URL
    func testFetchRecipesWithEmptyURL() async {
        let expectation = XCTestExpectation(description: "Empty URL")
        
        await viewModel.fetchRecipes(from: .emptyRecipes)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.recipes.isEmpty, "Recipes should be empty for an empty endpoint.")
            XCTAssertEqual(self.viewModel.errorMessage, "No recipes available.", "Error message should indicate no recipes available.")
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 5.0)
    }

    // MARK: Test 2.1: Image Caching
    func testImageCaching() async {
        let testImageURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"

        // First load - should download and cache
        let image1 = await viewModel.loadImage(from: testImageURL)
        XCTAssertNotNil(image1, "Image should be downloaded and not nil.")

        // Second load - should retrieve from memory cache
        let image2 = await viewModel.loadImage(from: testImageURL)
        XCTAssertNotNil(image2, "Image should be retrieved from cache and not nil.")
        XCTAssertEqual(image1, image2, "Image from cache should be the same as the downloaded one.")
    }
}

// MARK: - String MD5 Tests
class StringMD5Tests: XCTestCase {
    func testMD5Hashing() {
        let original = "teststring"
        let expectedMD5 = "6f8db599de986fab7a21625b7916589c" // Precomputed MD5 hash
        XCTAssertEqual(original.md5, expectedMD5, "MD5 hash should match expected value.")
    }
}

