//
//  NewsDetailViewModel.swift
//  DailyNewsAppUnitTests
//
//  Created by MobiloApps on 14/03/22.
//

import XCTest
@testable import DailyNewsApp
class NewsDetailViewModelUnitTest: XCTestCase {
    
    func test_NewsDetailViewModel_FormatServerDate() {
        let expectedResult = "14-03-2022 11:34 AM"
        let news = getMockNewsObject()
        let newsDetailsViewModel = NewsDetailViewModel(news: news)
        let formattedDate = newsDetailsViewModel.getDateInDisplayFormat(news?.publishedAt ?? "")
        XCTAssertEqual(formattedDate, expectedResult)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getMockNewsObject() -> News? {
        if let url = Bundle.main.url(forResource: "MockNewsObject", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let news = try decoder.decode(News.self, from: data)
                return news
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
