//
//  NewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit


/// View model corresponds to NewsListViewController.
class NewsListViewModel {
    private var newsListFetcher: NewsDataDelegate?
    weak var coordinator : AppCoordinator?
    var searchQuery = ""
    var category:NewsCategory = .entertainment
    var pageNumber = 0
    var isPaginating = false
    
    /// Initializer
    /// - Parameter fetcher: fetcher fetches news data from server.
    init(fetcher: NewsDataDelegate? = NewsListFetcher()) {
        self.newsListFetcher = fetcher
    }
    
    /// Fetches news data from server.
    /// - Parameters:
    ///   - pagination: Bool to identify whether it is first request or paginated request.
    ///   - completion: completion handler to send data to viewcontroller
    func getNewsData(pagination: Bool = false, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        if pagination {
            isPaginating = true
            // increments the page number to fetch next page data
            pageNumber += 1
        }
        newsListFetcher?.fetchNews(searchQuery: searchQuery, category: category, pageNumber: pageNumber, completion: {[weak self] newsList, error in
            guard let weakSelf = self else { return }
            weakSelf.isPaginating = false
            completion(newsList, error)
        })
    }
}
