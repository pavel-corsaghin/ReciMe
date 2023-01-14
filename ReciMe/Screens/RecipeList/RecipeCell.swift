//
//  RecipeCell.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: RecipeEntity
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: recipe.imageUrl.orEmpty),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                    
                },
                placeholder: {
                    Image("Placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }
            )

            
            VStack (alignment: .leading, spacing: 4) {
                HStack {
                    Text(recipe.title.orEmpty)
                        .font(.body)
                    Spacer()
                    
                    Image(recipe.liked.or(false) ? "like_fill" : "like")
                }
                
                HStack (spacing: 2) {
                    ForEach(0 ..< 5) { item in
                        Image("star")
                            .renderingMode(.template)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }.padding(.top)
                
                HStack {
                    Image("serving")
                    Text("\(recipe.servingSize.or(0)) Serving")
                        .font(.caption2)
                        .foregroundColor(Color("GrayColor"))
                    
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("LightGrayColor"))
        .cornerRadius(18.0)
    }
}
