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
                    .font(.system(size: 18, weight: .bold))
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(article.byline)
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text(article.publishedDate ?? "")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.blue.opacity(0.6))
                    }
                    Spacer()
                }
            }.padding(.all, 10)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: 160)
            .overlay(alignment: .trailing, content: {
                VStack {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.white)
                }.padding(.trailing, 4)
            })
            .padding(.horizontal, 8)
    }
}

#Preview {
    EmailedCell(article: ArticleResults.articleResultsModel())
}
