//
//  PixaBaySearchAPI.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//


import Foundation


enum PixaBaySearchAPI: APIEndPoint, URLRequestConvertible {
    
    case search(query: String, page: Int)

}

extension PixaBaySearchAPI {
    
    var baseURL: URL {

        return URL(string: APIConstants.pixabayAPIBaseURL)!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/api/"
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .search(query, page):
            return [
                "key": APIConstants.pixabayAPIKey,
                "q": query,
                "image_type":"photo",
                "page": page,
                "per_page": Constants.defaultPageSize
            ]
        }
    }
    
}
