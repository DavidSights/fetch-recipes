//
//  DataProvider.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/5/25.
//

import Foundation

enum RecipesSource: String {
    case valid = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

struct NetworkManager {

    func fetchRecipes(_ source: RecipesSource = .valid) async throws -> [Recipe] {
        guard let url = URL(string: source.rawValue) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)

        return recipeResponse.recipes
    }
}

