//
//  PixaBayPhoto.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation

// MARK: - PixaBayPhoto
struct PixaBayPhoto: Codable {
    let largeImageURL: String?
    let favorites: Int?
    let tags: String?
    let webformatHeight, downloads, imageWidth, likes: Int?
    let userID, imageHeight: Int?
    let webformatURL: String?
    let webformatWidth, views: Int?
    let type: String?
    let pageURL: String?
    let id, previewHeight: Int?
    let previewURL: String?
    let user: String?
    let previewWidth, comments: Int?
    let userImageURL: String?
    let imageSize: Int?

    enum CodingKeys: String, CodingKey {
        case largeImageURL, favorites, tags, webformatHeight, downloads, imageWidth, likes
        case userID
        case imageHeight, webformatURL, webformatWidth, views, type, pageURL, id, previewHeight, previewURL, user, previewWidth, comments, userImageURL, imageSize
    }
}
