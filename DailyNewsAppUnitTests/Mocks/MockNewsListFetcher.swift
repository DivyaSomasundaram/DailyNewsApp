//
//  MockNewsListFetcher.swift
//  DailyNewsAppUnitTests
//
//  Created by MobiloApps on 14/03/22.
//

import Foundation

@testable import DailyNewsApp

class MockNewsListFetcher {
    
    var shouldReturnError = false
    var error: APIError?
    var newsList = [News]()
    
    init(_ shouldReturnError: Bool =  false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func mockResponse() -> [News]? {
        return getNewsListFromJSON()
    }
    
    func getNewsListFromJSON() -> [News]? {
        if let url = Bundle.main.url(forResource: "MockNewsListApiResponse", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NewsAPIResponse.self, from: data)
                return jsonData.articles
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension MockNewsListFetcher: NewsDataDelegate {
    func fetchNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping ([News]?, APIError?) -> ()) {
        if shouldReturnError {
            completion(nil, error)
        } else {
            if let newsList = getNewsListFromJSON() {
                completion(newsList,nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
