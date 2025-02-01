//
//  NewsViewModel.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import SwiftUI
import CoreData


final class NewsViewModel: ObservableObject {
    
    static var shared = NewsViewModel()
    
    @Published var mostEmailed: News
    @Published var mostViewed: News
    @Published var mostShared: News
  
    @Published var favoritesArray: [SaveNewsCoreData] = []
    @Published var selectedEmailed: String? = nil
    @Published var selectedMostViewed: String? = nil
    @Published var selectedMostShared: String? = nil
    @Published var isShowAlert: Bool = false

    @Published var errorMassage: String = ""
    let period = 30
    
    private init(mostEmailed: News? = nil, mostViewed: News? = nil, mostShared: News? = nil) {
        self.mostEmailed = mostEmailed ?? News(status: "", copyright: "", numResults: 0, results: [])
        self.mostViewed = mostViewed ?? News(status: "", copyright: "", numResults: 0, results: [])
        self.mostShared = mostShared ?? News(status: "", copyright: "", numResults: 0, results: [])
        fetchAllNews()
        fetchMyFavorites()
    }
    
    var filteredEmailedNews: [ArticleResults] {
        filterNews(news: mostEmailed, selectedCategory: selectedEmailed ?? "")
    }

    var filteredSharedNews: [ArticleResults] {
        filterNews(news: mostShared, selectedCategory: selectedMostShared ?? "")
    }

    var filteredViewedNews: [ArticleResults] {
        filterNews(news: mostViewed, selectedCategory: selectedMostViewed ?? "")
    }
    var emailedCategories: [String] {
        return Set(mostEmailed.results.compactMap { $0.section }).sorted()
    }

    var sharedCategories: [String] {
        return Set(mostShared.results.compactMap { $0.section }).sorted()
    }

    var viewedCategories: [String] {
        return Set(mostViewed.results.compactMap { $0.section }).sorted()
    }
    
    private func fetchAllNews() {
        let group = DispatchGroup()
        
        group.enter()
        fetchNews(requestType: .emailed) { [weak self] news in
            self?.mostEmailed = news
            group.leave()
        }

        group.enter()
        fetchNews(requestType: .shared) { [weak self] news in
            self?.mostShared = news
            group.leave()
        }

        group.enter()
        fetchNews(requestType: .viewed) { [weak self] news in
            self?.mostViewed = news
            group.leave()
        }

        group.notify(queue: .main) {
            print("fetch all data")
        }
    }
    
    private func fetchNews(requestType: APIService.RequestType, completion: @escaping (News) -> Void) {
        APIService.shared.fetchNews(period: period, requestType: requestType) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    completion(self.filterNewsByDate(news: news))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isShowAlert = true
                    self.errorMassage = error.localizedDescription
                }
            }
        }
    }
    
    private func fetchMyFavorites() {
        if let item = PersistenceController.shared.fetchAllItems() {
            DispatchQueue.main.async {
                self.favoritesArray = item
            }
        }
    }
    
    private func filterNews(news: News, selectedCategory: String?) -> [ArticleResults] {
        var results = news.results
        
        if let selectedCategory = selectedCategory, !selectedCategory.isEmpty {
            results = results.filter { $0.section == selectedCategory }
        }
        
        results = results.map { article in
            var clearArticle = article
            clearArticle.sanitizeKeywords()
            return clearArticle
        }
        
        return results
    }
    
    private func filterNewsByDate(news: News) -> News {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let sortedResults = news.results.sorted { article1, article2 in
            guard let dateString1 = article1.publishedDate, let dateString2 = article2.publishedDate else {
                return false
            }
            if let date1 = formatter.date(from: dateString1), let date2 = formatter.date(from: dateString2) {
                return date1 > date2
            }
            return false
        }
        return News(
            status: news.status,
            copyright: news.copyright,
            numResults: news.numResults,
            results: sortedResults
        )
    }
    
    func removeFavorites(favorites: SaveNewsCoreData) {
        if let index = favoritesArray.firstIndex(where: {$0.id == favorites.id}) {
            self.favoritesArray.remove(at: index)
            PersistenceController.shared.deleteItem(item: favorites)
        }
    }
    
    func addNewsInMyFavorites(article: ArticleResults) {
        if !favoritesArray.contains(where: {$0.id == article.id ?? Int()}) {
            
            guard let id = article.id,
                  let publishedDate = article.publishedDate,
                  let adxKeywords = article.adxKeywords,
                  let imageUrl = getlImageUrl(from: article) else { return }
            
            APIService.shared.loadImage(from: imageUrl) { image in
                guard let image = image, let imageData = image.pngData() else { return }
                
                let addItem = PersistenceController.shared.addItem(
                    id: id,
                    title: article.title,
                    url: article.url,
                    creator: article.byline,
                    description: article.abstract,
                    image: imageData,
                    date: publishedDate,
                    adxKeywords: adxKeywords)
                
                DispatchQueue.main.async {[weak self] in
                    guard let self else { return}
                    self.favoritesArray.append(addItem)
                }
            }
        }
    }
    
    private func getlImageUrl(from article: ArticleResults) -> String? {
        guard let media = article.media.first else { return nil }
        return media.mediaMetadata.last?.url
    }
}
