//
//  RecipeService.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation
import Combine

protocol RecipeService {
    func getRecipes() -> AnyPublisher<Result<RecipesResponse, NetworkError>, Never>
}

extension Network: RecipeService {
    func getRecipes() -> AnyPublisher<Result<RecipesResponse, NetworkError>, Never> {
        request(RecipeEndpoint.recipeList, requestModifier: { request in
            request.acceptingJSON()
        })
    }
}
