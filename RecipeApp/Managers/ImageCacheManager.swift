//
//  CachedImageVIew.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/5/25.
//

import UIKit

struct ImageCacheManager {
    static let cache = NSCache<NSString, UIImage>()

    static func image(for urlString: String) async throws -> UIImage {

        // Return cached image if available
        if let cachedImage = cache.object(forKey: urlString as NSString) { return cachedImage }

        // Fetch image based on URL string
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                // Cache for future reference, and return image
                cache.setObject(image, forKey: urlString as NSString)
                return image
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            throw URLError(.badServerResponse)
        }
    }

    static func removeImage(for urlString: String) {
        cache.removeObject(forKey: urlString as NSString)
    }

    static func clearCache() {
        cache.removeAllObjects()
    }
}
