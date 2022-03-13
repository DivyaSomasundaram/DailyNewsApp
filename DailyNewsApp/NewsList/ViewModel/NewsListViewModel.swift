//
//  NewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit

class NewsListViewModel {
    var newsListFetcher: NewsDataDelegate?
    weak var coordinator : AppCoordinator?
    
    init(fetcher: NewsDataDelegate? = NewsListFetcher()) {
        self.newsListFetcher = fetcher
    }
    
    func getNewsData(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        newsListFetcher?.fetchNews(searchQuery: searchQuery, category: category, pageNumber: pageNumber, completion: { newsList, error in
            completion(newsList, error)
        })
    }
}
