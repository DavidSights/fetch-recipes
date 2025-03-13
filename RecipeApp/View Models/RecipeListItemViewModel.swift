//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/12/25.
//

protocol RecipeListItemViewModel {
    var uuid: String { get }
    var name: String { get }
    var cuisine: String { get }
    var sourceURL: String? { get }
    var youtubeURL: String? { get }
    var photoURLSmall: String { get }
}
