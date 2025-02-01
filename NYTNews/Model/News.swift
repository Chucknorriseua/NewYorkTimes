//
//  Welcome.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import Foundation

// MARK: - News
struct News: Codable, Hashable {

    let status, copyright: String
    let numResults: Int?
    var results: [ArticleResults]

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

enum Source: String, Codable, Hashable {
    case newYorkTimes = "New York Times"
}


enum ResultType: String, Codable {
    case article = "Article"
    case interactive = "Interactive"
}

