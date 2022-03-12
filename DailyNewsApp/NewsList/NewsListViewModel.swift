//
//  NewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class NewsListViewModel {
    var newsListArray = [News]()
    var newsListFetcher: NewsDataDelegate?
    
    init(fetcher: NewsDataDelegate? = NewsListFetcher()) {
        self.newsListFetcher = fetcher
    }
    
    func getNewsData(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        newsListFetcher?.fetchNews(searchQuery: searchQuery, category: category, pageNumber: pageNumber, completion: { [weak self] newsList, error in
            guard let weakSelf = self else {
                return
            }
            weakSelf.newsListArray = newsList ?? []
        })
    }
}
