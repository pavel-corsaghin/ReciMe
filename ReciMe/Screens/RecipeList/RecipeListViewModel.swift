//
//  RecipeListViewModel.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let service: RecipeService = Network.shared
    private var cancellables = Set<AnyCancellable>()

    @Published var recipes: [RecipeEntity] = []
    @Published var isLoading: Bool = false
    
    func fetchRecipes() {
        isLoading = true
        service.getRecipes()
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.recipes = response
                case .failure(let err):
                    Logger.log(err.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }
}
