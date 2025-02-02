//
//  SharedController.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct SharedController: View {
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    @State private var isShowCategory: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(newsViewModel.filteredSharedNews, id: \.self) { article in
                            NavigationLink(destination: ArticleDetailseView(articleResults: article)) {
                                EmailedCell(article: article)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 50)
                }
                .scrollIndicators(.hidden)
                .background(.ultraThinMaterial)
                .background(Color.mint.opacity(0.4))
           
            }
            .overlay(alignment: .center) {
                VStack {
                    CustomPicker(article: newsViewModel.sharedCategories, selectedCtegory: $newsViewModel.selectedMostShared, isShowCategory: $isShowCategory)
                }
            }
            .onDisappear {
                isShowCategory = false
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    withAnimation {
                        VStack {
                            Text(newsViewModel.selectedMostShared ?? "")
                                .font(.system(size: 26, weight: .bold))
                                .foregroundStyle(Color.white)
                                .underline(color: .white.opacity(0.5))
                        }.padding(.leading)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    CustomButtonCategory(isShowCategory: $isShowCategory)
                }
            }
        }
    }
}

