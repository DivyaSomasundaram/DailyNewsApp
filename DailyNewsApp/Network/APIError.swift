//
//  APIError.swift
//  DailyNewsApp
//
//  Created by divya Dinesh on 14/03/22.
//

import Foundation

enum APIError: Error {
    case unknownError
    case networkError
    case invalidAPIKey
    case notFound
    case serverError
    case serverUnavailable
    case timeOut
    case parsingError
    case responseError
    
    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Something went wrong.Please try again"
        case .networkError:
            return "Network error.Please try again"
        case .invalidAPIKey:
            return "Invalid Api key.Please try again"
        case .notFound:
            return "No Data found.Please try again"
        case .serverError:
            return "Server Error.Please try again"
        case .serverUnavailable:
            return "Server unavailable.Please try again"
        case .timeOut:
            return "Request timed out"
        case .parsingError:
            return "Error in parsing response"
        case .responseError:
            return "Invalid Response.Please check request"
        }
    }
 }


