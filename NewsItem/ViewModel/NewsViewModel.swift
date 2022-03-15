//
//  NewsViewModel.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 12/03/22.
//

import UIKit

struct NewsDataModel {
    let title: String?
    let url: String?
    let detail: String?
    let content: String?
    let publisher: String?

}


class NewsViewModel {
    
    let numberOfSections = 1
    var newsResponse: NewsResponseModel?
    private var dataManager:NewsDataManaging
    var newsData = [NewsDataModel]()

    init(with dataManager: NewsDataManaging = NewsDataManager()) {
        self.dataManager = dataManager
    }
    
    var screenTitle: String {
        return "Today's NewsFeed"
    }
    
    var noOfRowsInSection: Int {
        return (newsResponse?.articles?.count ?? 0) 
    }
    
    func headerImageAtIndex(index: Int) -> String {
        return self.newsResponse?.articles?[index].urlToImage ?? ""
    }
    
    func titleAtIndex(index:Int) -> String {
        return self.newsResponse?.articles?[index].title ?? ""
    }
    
    func descriptionAtIndex(index:Int) -> String {
        return self.newsResponse?.articles?[index].description ?? ""
    }

    func newsItemAtIndex(index: Int) -> NewsDataModel {
        let newsDataModel = NewsDataModel(title: titleAtIndex(index: index), url: headerImageAtIndex(index: index), detail: descriptionAtIndex(index: index), content: "", publisher: "")
        return newsDataModel
    }
    
}

extension NewsViewModel : NewsDataManagerInputDataSource {

    var apiKey: String {
        return "19b1078acfc24482a1764783bd55482b"
    }
    
    var requestURL: String {
        return "https://newsapi.org/v2/top-headlines"
    }
    
    var country : String {
        return "in"
    }
    
}

extension NewsViewModel {
    
    func fetchNewsDetailsforSelectedDate(_ callback: @escaping(Result<NewsResponseModel, Error>) -> Void) {
        
        self.dataManager.fetchNewsData(self) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let newsModel):
                strongSelf.newsResponse = newsModel
                callback(response)
            case .failure(let error):
                print("Error", error.localizedDescription)
                callback(.failure(error))
            }
        }
    }
}

