//
//  EmailedCell.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI

struct EmailedCell: View {
    
    @State var article: ArticleResults
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(article.title)
                    .foregroundStyle(Color.yellow)
                    .font(.headline)
                HStack {
                    VStack(alignment: .leading) {
                        Text(article.byline)
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(article.publishedDate ?? "")
                            .font(.caption)
                            .foregroundColor(.blue.opacity(0.6))
                    }
                    Spacer()
                }
            }.padding(.all, 10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: 160)
        .background(.ultraThinMaterial.opacity(0.8))
            .clipShape(.rect(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray, .white.opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            )
            .overlay(alignment: .trailing, content: {
                VStack {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.blue.opacity(0.5))
                }.padding(.trailing, 4)
            })
            .padding(.horizontal, 8)
    }
}

#Preview {
    EmailedCell(article: ArticleResults.articleResultsModel())
}
