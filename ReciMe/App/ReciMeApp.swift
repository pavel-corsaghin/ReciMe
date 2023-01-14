//
//  ReciMeApp.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import SwiftUI

@main
struct ReciMeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(viewModel: RecipeListViewModel())
        }
    }
}
