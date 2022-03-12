//
//  MockNewsListViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class MockNewsListViewModel: NewsDataDelegate {
    
    func getNewsData(searchQuery: String?, category: NewsCategory?, pageNumber: Int?) -> [News] {
        return []
    }
}
