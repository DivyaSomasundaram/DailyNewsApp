//
//  Constants.swift
//  DailyNewsApp
//
//  Created by Divya Dinesh on 12/03/22.
//

import Foundation
import UIKit

struct Constants {
    struct NetworkConstants {
        static let API_KEY = "a87aa2907a464ce6b347a74f85449070"
        static let DEFAULT_PAGE_SIZE = "20"
    }
    
    struct NewsListConstants {
        static let CELL_IDENTIFIER = "NewsListCell"
        static let DEFAULT_CELL_HEIGHT: CGFloat = 130
        static let NEWS_IMAGE_HEIGHT: CGFloat = 90
        static let NEWS_IMAGE_WIDTH: CGFloat = 110
        static let DEFAULT_PADDING: CGFloat = 10
        static let TITLE_PADDING: CGFloat = 10
        static let TITLE_FONT_SIZE: CGFloat = 16
        static let ERROR_TITLE_FONT_SIZE: CGFloat = 18
        static let DESCRIPTION_FONT_SIZE: CGFloat = 14
        static let DEFAULT_CATEGORY = NewsCategory.entertainment
        static let FOOTER_HEIGHT: CGFloat = 100
     }
    
    struct NewsDetailConstant {
        static let IMAGE_HEIGHT: CGFloat = 1/3
    }
}
