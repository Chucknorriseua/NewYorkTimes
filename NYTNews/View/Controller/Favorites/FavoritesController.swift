//
//  FavoritesController.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 31/01/2025.
//

import SwiftUI

struct FavoritesController: View {
    
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(newsViewModel.favoritesArray, id: \.self) { article in
                        FavoritesDetailsView(newsVm: newsViewModel, favorites: article)
                            .transition(.opacity)
                    }
                }.padding(.top, 0)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 8)
            }.scrollIndicators(.hidden)
                .background(.ultraThinMaterial)
                .background(Color.mint.opacity(0.4))
        }
    }
}
