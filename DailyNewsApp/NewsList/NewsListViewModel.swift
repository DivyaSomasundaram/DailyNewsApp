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
    
    init(fetcher: NewsDataDelegate? = NewsListFetcher()) {
        self.newsListFetcher = fetcher
    }
    
    func getNewsData(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        newsListFetcher?.fetchNews(searchQuery: searchQuery, category: category, pageNumber: pageNumber, completion: { newsList, error in
            completion(newsList, error)
        })
    }
    
    func getNewsImage(path: String, completion: @escaping((_ imageData: Data?,_ error: Error?) ->())) {
        let imageLoader = ImageLoader.init(path: path)
        imageLoader.loadImage {  imageData , error in
            completion(imageData, error)
        }
    }
}
