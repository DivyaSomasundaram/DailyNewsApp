//
//  NewsDataDelegate.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

protocol NewsDataDelegate {
    func fetchNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) 
}
