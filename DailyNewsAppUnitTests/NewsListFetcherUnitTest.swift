//
//  NewsListFetcherUnitTest.swift
//  DailyNewsAppUnitTests
//
//  Created by MobiloApps on 14/03/22.
//

import XCTest
@testable import DailyNewsApp

class NewsListFetcherUnitTest: XCTestCase {
    let newsListFetcher = MockNewsListFetcher()

    func test_NewsListFetcher_SuccessResponse() {
        let expectation = self.expectation(description: "News list API expection")
        let mockNewsList = newsListFetcher.mockResponse()
        newsListFetcher.fetchNews(searchQuery: "", category: NewsCategory.entertainment, pageNumber: 0) { newsList, error in
            XCTAssertNil(error)
            XCTAssertNotNil(newsList)
            XCTAssertEqual(mockNewsList, newsList)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

    func test_NewsListViewModel_ResponseError() {
        newsListFetcher.shouldReturnError = true
        newsListFetcher.error = .serverError
        let newsListViewModel = NewsListViewModel(fetcher: newsListFetcher)
        newsListViewModel.getNewsData(pagination: false) { responseError in
           XCTAssertNotNil(responseError)
        }
    }

}
