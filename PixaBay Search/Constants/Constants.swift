//
//  Constants.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation
import UIKit

//MARK: String Constants
enum Strings {
    static let pixabaySearchTitle = "PixaBay Search"
    static let placeholder = "Search PixaBay images..."
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let error = "Error"
    static let close = "close"
}

//MARK: Numeric Constants
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 3
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
}


//MARK: NetworkAPI Constants

enum APIConstants {
    static let pixabayAPIBaseURL = "https://pixabay.com"
    static let pixabayAPIKey = "18736040-e0337fec92b6072683b791811"
}
