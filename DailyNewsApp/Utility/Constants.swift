//
//  Constants.swift
//  DailyNewsApp
//
//  Created by MobiloApps on 12/03/22.
//

import Foundation
import UIKit

struct Constants {
    struct NetworkConstants {
        static let API_KEY = "2271bb4eea8e4f34b7956b595a497f9a"
        static let DEFAULT_PAGE_SIZE = "100"
    }
    
    struct NewsListConstants {
        static let DEFAULT_CELL_HEIGHT: CGFloat = 110
        static let NEWS_IMAGE_HEIGHT: CGFloat = 120
        static let NEWS_IMAGE_WIDTH: CGFloat = 120
        static let DEFAULT_PADDING: CGFloat = 10
        static let TITLE_FONT_SIZE: CGFloat = 20
        static let DESCRIPTION_FONT_SIZE: CGFloat = 15
     }
}
