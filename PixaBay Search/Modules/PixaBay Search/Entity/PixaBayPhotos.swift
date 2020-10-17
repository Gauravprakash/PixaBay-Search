//
//  PixaBayPhotos.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation

struct PixaBayPhotos: Codable {
    let totalHits: Int?
    let hits: [PixaBayPhoto]?
    let total: Int?
}


