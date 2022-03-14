//
//  DailyNewsAppUnitTests.swift
//  DailyNewsAppUnitTests
//
//  Created by MobiloApps on 14/03/22.
//

import XCTest
@testable import DailyNewsApp

class NewsListViewModelUnitTests: XCTestCase {
    let newsListFetcher = MockNewsListFetcher()
    
    func test_NewsListViewModel_SuccessResponse() {
        let expectation = self.expectation(description: "News list API expection")
        let newsListViewModel = NewsListViewModel(fetcher: newsListFetcher)
        newsListViewModel.newsListArray = []
        newsListViewModel.getNewsData(pagination: false) { responseError in
           XCTAssertNil(responseError)
           XCTAssertTrue(!newsListViewModel.newsListArray.isEmpty)
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
