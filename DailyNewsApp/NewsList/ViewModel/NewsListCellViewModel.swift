//
//  NewsListCellViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation


/// View model corresponds to NewListCell.
class NewsListCellViewModel {
    
    /// Get news image from server
    /// - Parameters:
    ///   - path: image path
    ///   - completion: completion to send data back to cell.
    func getNewsImage(path: String, completion: @escaping((_ imageData: Data?,_ error: Error?) ->())) {
        let imageLoader = ImageLoader.init(path: path)
        imageLoader.loadImage {  imageData , error in
            completion(imageData, error)
        }
    }
}
