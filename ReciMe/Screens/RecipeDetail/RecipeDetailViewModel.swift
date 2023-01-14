//
//  RecipeDetailViewModel.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    
    // MARK: - Properties

    let recipe: RecipeEntity

    init(_ recipe: RecipeEntity) {
        self.recipe = recipe
    }
}
