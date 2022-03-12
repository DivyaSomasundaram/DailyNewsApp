//
//  NetworkManager.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import Foundation
import CoreData

/// Network Manager class makes network calls to fetch data from server.
class NetworkManager {
    /// Executes the web service call and will decode the JSON response into the Codable object provided
    /// - Parameters:
    /// - endpoint: the endpoint to make the HTTP request against
    /// - completion: the JSON response converted to the provided Codable object, if successful, or failure otherwise
    
    class func request(endpoint: Endpoint, completion: @escaping(Result <Data, Error>) -> ()) {
            var requestURL: URL?
            if let fullUrl = endpoint.fullUrl { // If we are having complete url we are ignoring base url and path.
                requestURL = fullUrl
            } else if let baseUrl  = endpoint.baseURL {
                requestURL = baseUrl.appendingPathComponent(endpoint.path)
            }
            guard let requestUrl = requestURL else {
                print("Error in constructing url")
                return
            }
            
            var requestUrlComponents = URLComponents.init(url: requestUrl, resolvingAgainstBaseURL: false)
            requestUrlComponents?.queryItems = endpoint.parameters
            
            guard let url = requestUrlComponents?.url else {
                print("Error in constructing url")
                return
            }
            
            var urlRequest = URLRequest.init(url: url)
            urlRequest.httpMethod = endpoint.method.rawValue
            
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: urlRequest) {data, response, error in
                if let responseError = error {
                    completion(.failure(responseError))
                    print(responseError .localizedDescription)
                    return
                } else {
                    guard response != nil, let data = data else {
                        return
                    }
                    completion(.success(data))
                }
            }
            dataTask.resume()
    }
}
