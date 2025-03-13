//
//  RecipeAPITests.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/7/25.
//

import XCTest

@testable import RecipeApp

final class RecipeAPITests: XCTestCase {

    override func setUp() async throws {
        try await super.setUp()
    }

    override func tearDown() async throws {
        try await super.tearDown()
    }

    func testFetchValidRecipes() async throws {
        let networkManager = NetworkManager()
        do {
            let recipes = try await networkManager.fetchRecipes()
            XCTAssertFalse(recipes.isEmpty, "Valid recipes should not be empty")
        } catch {
            XCTFail("Fetching valid recipes should not throw an error: \(error)")
        }
    }

    func testFetchMalformedRecipes() async throws {
        let networkManager = NetworkManager()
        do {
            _ = try await networkManager.fetchRecipes(.malformed)
            XCTFail("Fetching malformed data should throw an error")
        } catch {
            XCTAssertTrue(error is DecodingError || error is URLError, "Error should be a decoding or URL error")
        }
    }

    func testFetchEmptyRecipes() async throws {
        let networkManager = NetworkManager()
        do {
            let recipes = try await networkManager.fetchRecipes(.empty)
            XCTAssertTrue(recipes.isEmpty, "Fetching empty recipes should return an empty array")
        } catch {
            XCTFail("Fetching empty recipes should not throw an error: \(error)")
        }
    }
}
