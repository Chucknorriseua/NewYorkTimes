//
//  FavoritesController.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 31/01/2025.
//

import SwiftUI

struct FavoritesController: View {
    
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    @State private var isShowDetailse: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(newsViewModel.favoritesArray, id: \.self) { article in
                        FavoritesDetailsView(newsVm: newsViewModel, favorites: article)
                            .transition(.scale)
                    }
                }.padding(.top, 0)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 8)
                .transition(.scale)
            }.scrollIndicators(.hidden)
                .background(.ultraThinMaterial)
                .background(Color.mint.opacity(0.4))
            
        }
    }
}
