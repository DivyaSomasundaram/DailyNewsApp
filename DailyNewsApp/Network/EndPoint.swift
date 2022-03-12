//
//  EndPoint.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import Foundation

/// Protocol defining basic properties of EndPoint.
protocol Endpoint {
    // Server base url.
    var baseURL: URL? {
        get
    }
    
    // Complete Url of resource.
    var fullUrl: URL? {
        get
    }
    
    // Server endpoint path.
    var path: String {
        get
    }
    
    // Query parameters sent in the request.
    var parameters: [URLQueryItem]? {
        get
    }
    
    // Http method.
    var method: HTTPMethod {
        get
    }
}
