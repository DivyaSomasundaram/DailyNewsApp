//
//  NewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class NewsListViewModel {
    var newsListArray = ["News", "News", "News", "News", "News", "News", "News"]
    var newsListFetcher: NewsDataDelegate?
    
    init(fetcher: NewsDataDelegate? = NewsListFetcher()) {
        self.newsListFetcher = fetcher
    }
}
