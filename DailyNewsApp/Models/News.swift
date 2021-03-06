//
//  News.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

struct News: Codable, Equatable {
    let title: String?
    let description: String?
    let publishedAt: String?
    let imageUrl: String?
    let newsUrl: String?
    let author: String?
    let content: String?
    let source: Source?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case publishedAt
        case imageUrl = "urlToImage"
        case newsUrl = "url"
        case author
        case content
        case source
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.title == rhs.title {
            return true
        } else {
            return false
        }
    }}

struct Source: Codable {
    let id: String?
    let name: String
}

struct NewsAPIResponse: Codable {
    let totalResults: Int?
    let status: String?
    let articles: [News]?
    let message: String?
}
