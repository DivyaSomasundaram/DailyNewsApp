//
//  DailyNewsEndpoint.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import Foundation

/// Defining end points needed for DailyNewsAPP and its properties.
enum DailyNewsEndpoint: Endpoint {
    
    /// Endpoint to fetch all the news.
    /// Everything endpoint from https://newsapi.org
    case getAllNews(searchQuery: String, category: NewsCategory, pageNumber: Int)
    
    /// Endpoint to fetch Top headlines.
    /// Top Headlines endpoint from https://newsapi.org
    case getTopHeadlines(searchQuery: String, category: NewsCategory, pageNumber: Int)
    
    /// Endpoint to fetch image corresponding to News.
    case getImageData(path: String)
    
    var baseURL: URL? {
        return URL(string: "https://newsapi.org")
    }
    
    var fullUrl: URL? {
        switch self {
        case .getImageData(let path):
            return URL(string: path)
        default:
            return nil
        }
    }
    
    var path: String {
        return "v2/everything"
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getAllNews(let searchQuery, let category, let pageNumber),
                .getTopHeadlines(let searchQuery, let category, let pageNumber):
            let apiKey = Contants.NetworkConstants.API_KEY
            var queryParameterArray = [URLQueryItem(name: "api_key", value: apiKey),
                                       URLQueryItem(name: "page", value: "\(pageNumber)"),
                                       URLQueryItem(name: "pageSize", value: Contants.NetworkConstants.DEFAULT_PAGE_SIZE)]
            if !searchQuery.isEmpty {
                queryParameterArray.append(URLQueryItem(name: "q", value: searchQuery))
            }
            
            if !category.rawValue.isEmpty {
                queryParameterArray.append(URLQueryItem(name: "category", value: category.rawValue))
            }
            return queryParameterArray
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
}
