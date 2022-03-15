//
//  NewsViewModelTests.swift
//  NewsItemTests
//
//  Created by Garima Ashish Bisht on 14/03/22.
//

import XCTest
@testable import NewsItem

class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!
    let dataManager = NewsMockDataManager()

    override func setUpWithError() throws {
        viewModel = NewsViewModel(with: dataManager)
        viewModel.newsResponse = dataManager.response
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchData() {
        viewModel.fetchNewsDetailsforSelectedDate { response in
            XCTAssertNotNil(response)
        }
    }

    func testScreenTitle() {
        XCTAssertEqual(viewModel.screenTitle, "Today's NewsFeed")
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.titleAtIndex(index: 0), "India vs Sri Lanka 2nd Test, Day 3 Highlights: India Thrash Sri Lanka By 238 Runs In Bengaluru, Clean Sweep 2-Match Series - NDTV Sports")
    }
    
    func testDescription() {
        XCTAssertEqual(viewModel.descriptionAtIndex(index: 0), "IND vs SL 2022 2nd Test, Highlights: India defeated Sri Lanka by 238 runs in the second Test match at the M Chinnaswamy Stadium in Bengaluru to clinch the series 2-0.")
    }
    
    func testImageURL() {
        XCTAssertEqual(viewModel.headerImageAtIndex(index: 0),"https://c.ndtvimg.com/2022-03/0ligskp8_axar-patel-india-bcci_625x300_14_March_22.jpg?im=FeatureCrop,algorithm=dnn,width=1200,height=675")
    }
    
    func testDataSource() {
        XCTAssertEqual(viewModel.noOfRowsInSection, 1)
    }
    
    func testNoOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testAPIKey() {
        XCTAssertEqual(viewModel.apiKey, "19b1078acfc24482a1764783bd55482b")
    }
    
    func testCountry() {
        XCTAssertEqual(viewModel.country, "in")
    }
    
    func testRequestURL() {
        XCTAssertEqual(viewModel.requestURL, "https://newsapi.org/v2/top-headlines")
    }

}
