//
//  NewsMockDataManager.swift
//  NewsItemTests
//
//  Created by Garima Ashish Bisht on 14/03/22.
//

import UIKit
@testable import NewsItem

class NewsMockDataManager: NewsDataManaging {
    
    var response: NewsResponseModel {
        let source = Source(id: "the-times-of-india", name: "The Times of India")

        let articles = Articles(source: source, author: "NDTV Sports Desk", title: "India vs Sri Lanka 2nd Test, Day 3 Highlights: India Thrash Sri Lanka By 238 Runs In Bengaluru, Clean Sweep 2-Match Series - NDTV Sports", description: "IND vs SL 2022 2nd Test, Highlights: India defeated Sri Lanka by 238 runs in the second Test match at the M Chinnaswamy Stadium in Bengaluru to clinch the series 2-0.", url: "https://sports.ndtv.com/india-vs-sri-lanka-2022/india-vs-sri-lanka-2022-2nd-test-day-3-ind-vs-sl-test-live-score-updates-2821566", urlToImage: "https://c.ndtvimg.com/2022-03/0ligskp8_axar-patel-india-bcci_625x300_14_March_22.jpg?im=FeatureCrop,algorithm=dnn,width=1200,height=675", publishedAt: "2022-03-14T12:23:11Z", content: "India vs Sri Lanka 2022 2nd Test Day 3 Ind vs SL Test Highlights: India defeated Sri Lanka by 238 runs in the second Test match at the M Chinnaswamy Stadium in Bengaluru to clinch the series 2-0. Sri… [+1101 chars]")
        
        let response = NewsResponseModel(status: "ok", totalResults: 10, articles: [articles])
        return response
    }
    
    
    func fetchNewsData(_ dataSource: NewsDataManagerInputDataSource, callback: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        
        callback(.success(response))

    }
    

}
