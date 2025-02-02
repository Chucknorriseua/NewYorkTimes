//
//  FavoritesDetailsView.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct FavoritesDetailsView: View {
    
   @ObservedObject var newsVm: NewsViewModel
   @State var favorites: SaveNewsCoreData
   @State private var isShow: Bool = false
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.spring(duration: 1)) {
                    isShow.toggle()
                }
            } label: {
                VStack {
                    if isShow {
                        VStack(spacing: 20) {

                            if let imageData = favorites.image,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 220)
                                    .clipShape(.rect(cornerRadius: 16))
                                
                            } else {
                
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text(favorites.title ?? "")
                                    .foregroundColor(Color.yellow.opacity(0.9))
                                    .font(.system(size: 26, weight: .bold))

                                
                                Text(favorites.desc ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                                
                                Text(favorites.adxKeywords ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .heavy, design: .serif))
                                 
                           
                                HStack {
                                    Spacer()
                                    if let url = URL(string: favorites.url ?? "") {
                                        Link("Read more", destination: url)
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .padding(8)
                                            .background(Color.blue)
                                            .clipShape(.rect(cornerRadius: 12))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                    Spacer()
                                }
                                Text(favorites.creator ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(Color.white.opacity(0.8))
                                VStack {
                                    if let publishedDate = favorites.date {
                                        Text("Published: \(publishedDate)")
                                            .font(.caption2)
                                            .foregroundColor(Color.white)
                                    }
                                }.padding([.horizontal, .vertical], 2)
                    
                            }.multilineTextAlignment(.leading)
                                .padding(.all, 6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }.overlay(alignment: .topTrailing) {
                            Button {
                                withAnimation(.easeOut(duration: 0.8)) {
                                    newsVm.removeFavorites(favorites: favorites)
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .font(.system(size: 28))
                                    .foregroundStyle(Color.white.opacity(0.7))
                            }.background(.ultraThinMaterial.opacity(0.6))
                                .clipShape(Circle())
                                .padding([.trailing, .top], 4)
                        }.transition(.scale)
                    
                    } else {
                        VStack {
                            Text(favorites.title ?? "")
                                .foregroundColor(Color.yellow.opacity(0.9))
                                .font(.system(size: 18, weight: .bold))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                                if let publishedDate = favorites.date {
                                    Text("Published: \(publishedDate)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white)
                                }
                            
                        }.padding(.all, 20)
                            .transition(.scale)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: isShow ? 800 : 140)
            .background(.ultraThinMaterial.opacity(0.8))
            .clipShape(.rect(cornerRadius: 16))
            .transition(.scale)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray, .white.opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            )
            .padding(.horizontal, 6)

        }
    }
}

//#Preview {
//    FavoritesDetailsView(newsVm: NewsViewModel.shared)
//
//}
