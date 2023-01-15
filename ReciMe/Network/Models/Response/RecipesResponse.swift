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
    let description: String?
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

extension RecipeEntity {
    
    static let mock: Self = .init(id: "0",
                                  title: "Easy poke bowl",
                                  description: "Yummiest summer drink",
                                  imageUrl: "https://recime-model-1.s3.ap-southeast-2.amazonaws.com/images/f810bf27-acf5-4ad6-b4e1-d693ac9c7f43.jpg",
                                  creator: .init(uid: "7NWpTwiUWQMm89GS3zJW7Is3Pej1",
                                                 username: "codingproject",
                                                 profileImageUrl: "https://recime-model-1.s3.ap-southeast-2.amazonaws.com/images/152137a2-bb71-4e52-8b2c-242c2e6ce26c.jpg",
                                                 isFollowing: false),
                                  cookTime: 5,
                                  difficulty: .easy,
                                  method: "Brown the ground beef well in a cast iron skillet over medium high. Set aside.\nSaute the onion and the first 5-6 cloves of garlic (reserve the other 3) in a large pot with a little olive oil or better yet, bacon grease. When translucent add the rest of the ingredients\nCook the rice\nMelt butter in a saucepan over medium heat. Add flour. Cook, stirring, with a wooden spoon, for 1 to 2 minutes or until mixture bubbles. Gradually stir in milk.\nBring to the boil. Reduce heat to medium. Cook, stirring, for 4 to 5 minutes or until mixture thickens. Season with salt and pepper. Allow to cool before refrigerating.",
                                  timestamp: nil,
                                  liked: true,
                                  saved: true,
                                  numLikes: 100,
                                  numSaves: 40,
                                  numComments: 8,
                                  numRecreates: 2,
                                  rating: 5,
                                  visibility: "PUBLISHED",
                                  tags: ["Healthy",
                                         "Lunch",
                                         "Snack",
                                         "Crowd-pleaser",
                                         "Side",
                                         "Entertaining",
                                         "Pescatarian",
                                         "Dinner"],
                                  cuisine: nil,
                                  servingSize: 5)
}
