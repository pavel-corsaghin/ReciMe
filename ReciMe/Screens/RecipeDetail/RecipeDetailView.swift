//
//  RecipeDetailView.swift
//  ReciMe
//
//  Created by HungNguyen on 2023/01/14.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var viewModel: RecipeDetailViewModel
    @SwiftUI.Environment(\.presentationMode) var presentation
    
    private let topImageWidth: Double = UIScreen.main.bounds.width
    private let topImageHeight: Double = UIScreen.main.bounds.height * 0.3
    private let creatorIconSize: Double = 24
    private var recipe: RecipeEntity { viewModel.recipe }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                AsyncImage(
                    url: URL(string: recipe.imageUrl.orEmpty),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: topImageWidth, height: topImageHeight)
                            .cornerRadius(8)
                    },
                    placeholder: {
                        Image("Placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: topImageWidth, height: topImageHeight)
                            .cornerRadius(8)
                    }
                )
                
                HStack {
                    Text(recipe.title.orEmpty)
                        .font(.title)
                        .bold()
                    Spacer()
                    HStack (spacing: 2) {
                        ForEach(0 ..< 5) { item in
                            Image("star")
                                .renderingMode(.template)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                    }.padding(.trailing, 10)
                }
                .padding(.leading, 10)
                
                if let creator = recipe.creator {
                    HStack {
                        AsyncImage(
                            url: URL(string: creator.profileImageUrl.orEmpty),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: creatorIconSize, height: creatorIconSize)
                                    .clipShape(Circle())
                            },
                            placeholder: {
                                Image("Placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: creatorIconSize, height: creatorIconSize)
                                    .clipShape(Circle())
                            }
                        )
                        Text("by").padding(.leading, 4)
                        Text(creator.username.orEmpty).foregroundColor(Color.orange).padding(.leading, -4)
                        Spacer()
                    }
                    .padding(.leading, 10)
                }
                
                
                VStack{
                    HStack {
                        Text("Method")
                            .font(.title2)
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    .padding(.vertical, 2)

                    Text(recipe.method.orEmpty)
                        .padding(.horizontal, 10)
                }
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

            })
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .padding(.all, 8)
                    .background(Color.black.opacity(0.8))
                    .clipShape(Circle())
            }
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(viewModel: RecipeDetailViewModel(RecipeEntity.mock))
    }
}
