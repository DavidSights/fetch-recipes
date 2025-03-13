//
//  URL+RecipeApp.swift
//  RecipeApp
//
//  Created by David Seitz Jr on 3/5/25.
//

import Foundation

extension URL: Identifiable {
    public var id: String { absoluteString }
}
