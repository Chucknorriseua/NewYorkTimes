//
//  EmailedController.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct EmailedController: View {
    
    
    @EnvironmentObject var newsViewModel: NewsViewModel

    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(newsViewModel.filteredEmailedNews, id: \.self) { article in
                        NavigationLink(destination: ArticleDetailseView(articleResults: article)) {
                            EmailedCell(article: article)
                            
                        }
                    }
                }.padding(.horizontal, 8)
                    .padding(.top, 46)
                    .padding(.bottom, 60)
                
            }.scrollIndicators(.hidden)
                .background(.ultraThinMaterial)
                .background(Color.mint.opacity(0.4))
            
                .overlay(alignment: .topTrailing) {
                    VStack {
                        Picker("", selection: $newsViewModel.selectedEmailed) {
                            Text("All").tag(nil as String?)
                            ForEach(newsViewModel.emailedCategories, id: \.self) { category in
                                Text(category).tag(category as String?)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color.white)
                        .padding(.all, 2)
              
                    }.background(Color.blue.opacity(0.6))
                        .clipShape(.rect(cornerRadius: 24))
                        .padding(.trailing, 12)
                }
         
        }
    }
}

#Preview {
    EmailedController()
}

