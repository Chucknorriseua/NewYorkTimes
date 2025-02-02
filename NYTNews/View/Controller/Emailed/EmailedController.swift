//
//  EmailedController.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct EmailedController: View {
    
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    @State private var isShowCategory: Bool = false

    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    LazyVStack {
                        ForEach(newsViewModel.filteredEmailedNews, id: \.self) { article in
                            NavigationLink(destination: ArticleDetailseView(articleResults: article)) {
                                EmailedCell(article: article)
                                
                            }
                        }
                    }.padding(.horizontal, 8)
                        .padding([.top, .bottom], 50)
                    
                }.scrollIndicators(.hidden)
                    .background(.ultraThinMaterial)
                    .background(Color.mint.opacity(0.4))
                    .overlay(alignment: .topTrailing, content: {
                        CustomButtonCategory(isShowCategory: $isShowCategory)
                    })
                    .overlay(alignment: .center) {
                        VStack {
                            CustomPicker(article: newsViewModel.emailedCategories, selectedCtegory: $newsViewModel.selectedEmailed, isShowCategory: $isShowCategory)
                        }
                    }
                    .onDisappear {
                        isShowCategory = false
                    }
            }
        }
    }
}

