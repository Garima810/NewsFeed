//
//  NewsResponseModel.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 12/03/22.
//

import Foundation

class NewsResponseModel: NSObject, Decodable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
    
    init(status: String?, totalResults: Int?, articles: [Articles]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }

}

class Articles: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }

}

class Source: NSObject, Decodable {
    let name: String?
    let id: String?
    
    init(id: String?, name: String?) {
        self.name = name
        self.id = id
    }

}
