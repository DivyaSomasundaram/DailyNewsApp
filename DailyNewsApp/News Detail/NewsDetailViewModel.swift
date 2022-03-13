//
//  NewsDetailViewModel.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 13/03/22.
//

import Foundation
import UIKit

/// News details view model to provide data to news detail view controller.
class NewsDetailViewModel {
    /// News item which user opened.
    let news: News?
    
    ///Image of news.
    var newsImage: UIImage?
    
    init(news: News) {
        self.news = news
    }
}
