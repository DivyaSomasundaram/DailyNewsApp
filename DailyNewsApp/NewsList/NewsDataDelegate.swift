//
//  NewsDataDelegate.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

protocol NewsDataDelegate {
    func getNewsData(searchQuery: String?, category: NewsCategory?, pageNumber: Int?) -> [News]
}
