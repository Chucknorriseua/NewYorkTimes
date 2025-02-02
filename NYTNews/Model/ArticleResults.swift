//
//  ArticleResults.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import Foundation

struct ArticleResults: Identifiable, Codable, Hashable {
    let uri: String
    let url: String
    let id, assetID: Int?
    let source: Source
    var publishedDate, updated, section: String?
    let subsection: Subsection
    var nytdsection, adxKeywords: String?
    let column: String?
    let byline: String
    let type: ResultType
    var title, abstract: String
    let desFacet, orgFacet, perFacet, geoFacet: [String]?
    let media: [Media]
    let etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    static func articleResultsModel() -> ArticleResults {
        return ArticleResults(uri: "", url: "", id: 0, assetID: 0, source: Source(rawValue: "") ?? .newYorkTimes, publishedDate: "", updated: "", section: "", subsection: Subsection(rawValue: "") ?? .eat, nytdsection: "", adxKeywords: "", column: "", byline: "", type: ResultType(rawValue: "") ?? .article, title: "", abstract: "", desFacet: [], orgFacet: [], perFacet: [], geoFacet: [], media: [], etaID: 0)
    }
    
    mutating func sanitizeKeywords() {
        if let adxKeywords = adxKeywords {
            self.adxKeywords = adxKeywords.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ";", with: ", ")
        }
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ";", with: " ")
        self.abstract = abstract.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ";", with: " ")
    }
}

