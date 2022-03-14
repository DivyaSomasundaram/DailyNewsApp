//
//  NewsListFetcher.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class NewsListFetcher: NewsDataDelegate {
    
    func fetchNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?, completion: @escaping(_ newsList: [News]?,_ error: APIError?) -> ()) {
        if NetworkReachability.shared.isNetworkAvailable() {
            NetworkManager.request(endpoint: DailyNewsEndpoint.getTopHeadlines(searchQuery: searchQuery, category: category, pageNumber: pageNumber)) { [weak self] (result: Result<Data, Error>) in
                switch(result) {
                case .success(let data):
                    self?.processResponse(data, completion: completion)
                case .failure(let error):
                    // set API Error for different server error codes here.
                    completion(nil, APIError.responseError)
                    print(error)
                }
            }
        } else {
            completion(nil, APIError.networkError)
        }
    }
    
    /// Process the response and decode the object.
    /// - Parameter data: data from the server
    func processResponse(_ data: Data, completion: @escaping(_ newsList: [News]?,_ error: APIError?) -> ()) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
            let decoder = JSONDecoder()
            let newsListResponse = try decoder.decode(NewsAPIResponse.self, from: data)
            if newsListResponse.status == NetworkAPIStatus.ok.rawValue {
                let newsList = newsListResponse.articles
                completion (newsList, nil)
            } else if newsListResponse.status == NetworkAPIStatus.error.rawValue {
                completion(nil, APIError.responseError)
            }
        } catch {
            if let error = error as? APIError {
                completion(nil, error)
            } else {
                print(error)
            }
        }
    }
}


