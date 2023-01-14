//
//  RecipeListView.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe))) {
                            RecipeCell(recipe: recipe)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Recipes")}
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(viewModel: RecipeListViewModel())
    }
}

