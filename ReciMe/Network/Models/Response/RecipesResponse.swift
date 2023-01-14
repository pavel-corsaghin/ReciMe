//
//  RecipesResponse.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import Foundation

typealias RecipesResponse = [RecipeEntity]

struct RecipeEntity: Decodable, Identifiable {
    let id: String
    let title: String?
    let imageUrl: String?
    let creator: CreatorEntity?
    let cookTime: Int?
    let difficulty: RecipeDifficulty?
    let method: String?
    let timestamp: Int?
    let liked: Bool?
    let saved: Bool?
    let numLikes, numSaves, numComments, numRecreates: Int?
    let rating: Double?
    let visibility: String?
    let tags: [String]?
    let cuisine: String?
    let servingSize: Int?
}

struct CreatorEntity: Decodable {
    let uid: String
    let username: String?
    let profileImageUrl: String?
    let isFollowing: Bool?
}

enum RecipeDifficulty: String, Decodable {
    case easy = "EASY"
    case medium = "MEDIUM"
    case hard = "HARD"
}
