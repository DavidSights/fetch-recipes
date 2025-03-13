//
//  ImageCacheManagerTests.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/7/25.
//

import XCTest
import UIKit

@testable import RecipeApp

final class ImageCacheManagerTests: XCTestCase {

    // Mock URL for testing
    let validImageURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
    let invalidImageURLString = "invalid-url"

    override func setUp() {
        super.setUp()
        ImageCacheManager.clearCache()
    }

    override func tearDown() {
        ImageCacheManager.clearCache()
        super.tearDown()
    }

    func testFetchingImageCachesIt() async throws {
        XCTAssertNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString))
        let image = try await ImageCacheManager.image(for: validImageURLString)
        XCTAssertNotNil(image, "Image should be fetched successfully")
        XCTAssertNotNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString), "Image should be cached after fetching")
    }

    func testFetchingCachedImageDoesNotRefetch() async throws {
        let firstFetchImage = try await ImageCacheManager.image(for: validImageURLString)
        XCTAssertNotNil(firstFetchImage, "Image should be fetched successfully")
        let cachedImageBefore = ImageCacheManager.cache.object(forKey: validImageURLString as NSString)
        let secondFetchImage = try await ImageCacheManager.image(for: validImageURLString)
        XCTAssertEqual(cachedImageBefore, secondFetchImage, "Cached image should be returned instead of refetching")
    }

    func testRemovingCachedImage() async throws {
        _ = try await ImageCacheManager.image(for: validImageURLString)
        XCTAssertNotNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString), "Image should be cached")
        ImageCacheManager.removeImage(for: validImageURLString)
        XCTAssertNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString), "Image should be removed from cache")
    }

    func testClearingCache() async throws {
        _ = try await ImageCacheManager.image(for: validImageURLString)
        ImageCacheManager.cache.setObject(UIImage(), forKey: "extra-test-image" as NSString)
        XCTAssertNotNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString), "First image should be cached")
        XCTAssertNotNil(ImageCacheManager.cache.object(forKey: "extra-test-image" as NSString), "Second image should be cached")
        ImageCacheManager.clearCache()
        XCTAssertNil(ImageCacheManager.cache.object(forKey: validImageURLString as NSString), "First image should be removed")
        XCTAssertNil(ImageCacheManager.cache.object(forKey: "extra-test-image" as NSString), "Second image should be removed")
    }

    func testInvalidURLThrowsError() async {
        do {
            _ = try await ImageCacheManager.image(for: invalidImageURLString)
            XCTFail("Fetching with an invalid URL should throw an error")
        } catch {
            XCTAssertTrue(error is URLError, "Error should be a URLError")
        }
    }
}
