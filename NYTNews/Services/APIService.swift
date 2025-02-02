//
//  APIService.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//


import SwiftUI
import Alamofire

enum NetworkError: Error {
    case urlError
    case responseError
    case decoderError
}

class APIService {
    
    static let shared = APIService()
    
    let apiKey = "i21zAoUd5RDW2q0Iq1nMr4J5WUzWcDDn"
    let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2"
    
    enum RequestType: String {
        case emailed = "emailed"
        case shared = "shared"
        case viewed = "viewed"
    }

    func fetchNews(period: Int, requestType: RequestType, completion: @escaping (Result<News, NetworkError>) -> Void) {
        let urlString = "\(baseUrl)/\(requestType.rawValue)/\(period).json?api-key=\(apiKey)"
        print("urlString:", urlString)

        AF.request(urlString)
            .validate(statusCode: 200..<300)
            .response { response in
                guard let data = response.data else {
                    completion(.failure(.responseError))
                    return
                }
                guard let news = try? JSONDecoder().decode(News.self, from: data) else {
                    completion(.failure(.decoderError))
                    return
                }
                
                dump(news.results)
                completion(.success(news))
            }
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
}
