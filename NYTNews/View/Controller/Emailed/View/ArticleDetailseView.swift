//
//  ArticleDetailseView.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct ArticleDetailseView: View {
    
    @State var articleResults: ArticleResults
    
    var body: some View {
        VStack {
            
            ScrollView {
                VStack(spacing: 20) {
                    if let media = articleResults.media.first, let metadata = media.mediaMetadata.last {
                        AsyncImage(url: URL(string: metadata.url)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .clipShape(.rect(cornerRadius: 24))
                                    .padding(.horizontal, 8)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .foregroundStyle(Color.white)
                                    .frame(width: 200, height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .foregroundStyle(Color.white)
                            .frame(width: 200, height: 200)
                    }
                    Group {
                        VStack(alignment: .center, spacing: 14) {
                            Text(articleResults.title)
                                .foregroundStyle(Color.yellow)
                                .font(.system(size: 22, weight: .heavy))
                            
                            Text(articleResults.abstract)
                                .foregroundStyle(Color.white)
                                .fontDesign(.monospaced)
                                .font(.system(size: 16, weight: .heavy))
                            
                            Text(articleResults.adxKeywords ?? "")
                                .font(.system(size: 10, weight: .heavy, design: .monospaced))
                                .truncationMode(.tail)
                            
                            
                            HStack {
                                Spacer()
                                HStack {
                                    
                                    if let url = URL(string: articleResults.url) {
                                        Link("Read more", destination: url)
                                            .foregroundStyle(Color.white)
                                            .font(.body)
                                            .padding(.all, 8)
                                    }
                                }.background(Color.blue)
                                    .clipShape(.rect(cornerRadius: 12))
                                Spacer()
                            }
                            
                            Text(articleResults.byline)
                                .font(.subheadline)
                                .foregroundColor(Color.white.opacity(0.8))
                            
                            if let publishedDate = articleResults.publishedDate {
                                Text("Published: \(publishedDate)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding([.horizontal, .leading], 4)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }.background(.ultraThinMaterial)
                .background(Color.mint.opacity(0.4))
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .fontWeight(.heavy)
                    .fontDesign(.serif)
                    .foregroundStyle(Color.white)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    NewsViewModel.shared.addNewsInMyFavorites(article: articleResults)
                } label: {
                    Image(systemName: "bookmark.fill")
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.white)
                }
            }
        })
    }
}

#Preview {
    ArticleDetailseView(articleResults: ArticleResults.articleResultsModel())
}

