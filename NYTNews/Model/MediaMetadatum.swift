//
//  MediaMetadatum.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import Foundation
// MARK: - MediaMetadatum
struct MediaMetadatum: Codable, Hashable {
    let url: String
    let format: Format
    let height, width: Int?
}
enum Subsection: String, Codable {
    case eat = "Eat"
    case move = "Move"
    case empty = ""

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
        case "Eat":
            self = .eat
        case "Move":
            self = .move
        case "Mind":
            self = .empty
        default:
            self = .empty
        }
    }
}

enum Format: String, Codable {
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case standardThumbnail = "Standard Thumbnail"
}
