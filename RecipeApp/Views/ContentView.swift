//
//  ContentView.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [RecipeListItemViewModel] = []
    @State private var sortOption: SortOption = .name

    enum SortOption: String, CaseIterable {
        case name = "Name"
        case cuisine = "Cuisine"
    }

    var sortedRecipes: [RecipeListItemViewModel] {
        switch sortOption {
        case .name:
            return recipes.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .cuisine:
            return recipes.sorted { $0.cuisine.localizedCaseInsensitiveCompare($1.cuisine) == .orderedAscending }
        }
    }

    var body: some View {
        NavigationStack {
            List(sortedRecipes, id: \.uuid) { recipe in
                RecipeRow(recipe: recipe)
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Button(action: { sortOption = option }) {
                                Text(option.rawValue)
                            }
                        }
                    } label: {
                        Text("Sort: \(sortOption.rawValue)")
                    }
                }
            }
            .task {
                await fetchRecipes()
            }
        }
    }

    func fetchRecipes() async {
        do {
            let fetchedRecipes = try await NetworkManager().fetchRecipes()
            self.recipes = fetchedRecipes
        } catch {
            print("Error fetching recipes:", error)
        }
    }
}

#Preview {
    ContentView()
}
