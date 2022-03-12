//
//  MockNewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class MockNewsListFetcher: NewsDataDelegate {
    func fetchNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping ([News]?, Error?) -> ()) {
    }
}
