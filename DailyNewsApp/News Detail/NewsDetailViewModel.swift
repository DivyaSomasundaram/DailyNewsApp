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
    
    /// Converts server date format into display format
    /// - Parameter serverDate: Date string in server format
    /// - Returns: Date string in display format.
    func getDateInDisplayFormat(_ serverDate: String) -> String {
        let serverFormat = DateFormatter()
        serverFormat.dateFormat = Constants.NewsDetailConstant.SERVER_DATE_FORMAT
        if let date = serverFormat.date(from: serverDate) {
            let userFormat = DateFormatter()
            userFormat.dateFormat = Constants.NewsDetailConstant.USER_DATE_FORMAT
            let dateString = userFormat.string(from: date)
            return dateString
        } else {
            return serverDate
        }
    }
}
