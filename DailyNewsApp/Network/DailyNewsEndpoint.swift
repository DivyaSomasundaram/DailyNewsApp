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
    case getAllNews(searchQuery: String?, category: NewsCategory?, pageNumber: Int?)
    
    /// Endpoint to fetch Top headlines.
    /// Top Headlines endpoint from https://newsapi.org
    case getTopHeadlines(searchQuery: String?, category: NewsCategory?, pageNumber: Int?)
    
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
        switch self {
        case .getAllNews(_, _, _):
            return "v2/everything"
        case .getTopHeadlines(_, _, _):
            return "v2/top-headlines"
        default:
            return ""
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getAllNews(let searchQuery, let category, let pageNumber), .getTopHeadlines(let searchQuery, let category, let pageNumber):
            let queryParameters = setQueryParameters(searchQuery: searchQuery, category: category, pageNumber: pageNumber)
            return queryParameters
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    func setQueryParameters(searchQuery: String?, category: NewsCategory?, pageNumber: Int?) -> [URLQueryItem] {
        let apiKey = Constants.NetworkConstants.API_KEY
        var queryParameterArray = [URLQueryItem(name: "apiKey", value: apiKey),
                                   URLQueryItem(name: "pageSize", value: Constants.NetworkConstants.DEFAULT_PAGE_SIZE)]
        if let searchString = searchQuery, !searchString.isEmpty {
            queryParameterArray.append(URLQueryItem(name: "q", value: searchString))
        }
        
        if let newsCategory = category, !newsCategory.rawValue.isEmpty {
            queryParameterArray.append(URLQueryItem(name: "category", value: newsCategory.rawValue))
        }
        
        if let pageNumber = pageNumber {
            queryParameterArray.append(URLQueryItem(name: "page", value: "\(pageNumber)"))
        }
        queryParameterArray.append(URLQueryItem(name: "country", value: "us"))

        return queryParameterArray
    }
}
