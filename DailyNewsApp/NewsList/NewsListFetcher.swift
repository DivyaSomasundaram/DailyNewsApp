//
//  NewsListFetcher.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class NewsListFetcher: NewsDataDelegate {
    
    func fetchNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        if NetworkReachability.shared.isNetworkAvailable() {
            NetworkManager.request(endpoint: DailyNewsEndpoint.getTopHeadlines(searchQuery: searchQuery, category: category, pageNumber: pageNumber)) { [weak self] (result: Result<Data, Error>) in
                switch(result) {
                case .success(let data):
                    self?.processResponse(data, completion: completion)
                case .failure(let error):
                    completion(nil, error)
                    print(error)
                }
            }
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [ NSLocalizedDescriptionKey: "No Internet. Please try again later"])
            completion(nil, error)
        }
    }
    
    /// Process the response and decode the object.
    /// - Parameter data: data from the server
    func processResponse(_ data: Data, completion: @escaping(_ newsList: [News]?,_ error: Error?) -> ()) {
        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print(json)
            let decoder = JSONDecoder()
            let newsListResponse = try decoder.decode(NewsAPIResponse.self, from: data)
            let newsList = newsListResponse.articles
            completion (newsList, nil)
        } catch {
            completion(nil, error)
            print(error)
        }
    }
}


