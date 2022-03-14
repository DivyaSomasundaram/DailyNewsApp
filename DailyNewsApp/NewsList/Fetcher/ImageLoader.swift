//
//  ImageLoader.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import Foundation
import UIKit

class ImageLoader {
    var imagePath: String?
    
    init(path: String) {
        imagePath = path
    }
    
    /// loads image from server or DB based on availability.
    func loadImage(completion: @escaping((Data?, Error?) -> ())) {
        if let path = imagePath  {
            if NetworkReachability.shared.isNetworkAvailable() {
                NetworkManager.request(endpoint: DailyNewsEndpoint.getImageData(path: path)) { (result: Result<Data, Error>) in
                    switch result {
                    case .success(let data):
                        completion(data, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                }
            } else {
              // Error handling.
            }
        }
    }
}
