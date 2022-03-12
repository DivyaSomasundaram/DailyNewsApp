//
//  NewsListCellViewModel.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation

class NewsListCellViewModel {
    
    func getNewsImage(path: String, completion: @escaping((_ imageData: Data?,_ error: Error?) ->())) {
        let imageLoader = ImageLoader.init(path: path)
        imageLoader.loadImage {  imageData , error in
            completion(imageData, error)
        }
    }
}
