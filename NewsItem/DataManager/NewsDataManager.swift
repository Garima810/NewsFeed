//
//  NewsDataManager.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 12/03/22.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case invalidResponse(URLResponse?)
}

protocol NewsDataManagerInputDataSource {
    var requestURL: String { get }
    var country : String { get }
//    var topic: String? { get }
//    var date: String? { get }
//    var sortBy: String? { get}
    var apiKey: String { get }
}

protocol NewsDataManaging {
    func fetchNewsData(_ dataSource: NewsDataManagerInputDataSource, callback: @escaping (Result<NewsResponseModel, Error>) -> Void)
}

class NewsDataManager: NewsDataManaging {
    
    func fetchNewsData(_ dataSource: NewsDataManagerInputDataSource, callback: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        
        var components = URLComponents(string: dataSource.requestURL)
        components?.queryItems = [
            URLQueryItem(name: "country", value: dataSource.country),
            URLQueryItem(name: "apikey", value: dataSource.apiKey)
          ]
        let request = URLRequest(url: (components?.url)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                if let error = error {
                    callback(.failure(error))
                    return
                }
                return
            }
            
            guard let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    callback(.failure(NetworkError.invalidResponse(response)))
                    return
            }
    
            do {
                let  data = try JSONDecoder().decode(NewsResponseModel.self, from: responseData)
                print(responseData.description)
                callback(.success(data))
            } catch {
                print(error.localizedDescription)
                callback(.failure(error))
            }
        }
        task.resume()
    }
    
}


