//
//  PixaBaySearchViewModel.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation

struct PixaBaySearchViewModel {
    
    var photoUrlList: [URL] = []
    
    init(photoUrlList: [URL]) {
        self.photoUrlList = photoUrlList
    }
    
    
    var isEmpty: Bool {
        return photoUrlList.isEmpty
    }
    
    var photoCount: Int {
        return photoUrlList.count
    }
    
    mutating func addMorePhotoUrls(_ photoUrls: [URL]) {
        self.photoUrlList += photoUrls
    }
}

extension PixaBaySearchViewModel {
    
    func imageUrlAt(_ index: Int) -> URL {
        guard !photoUrlList.isEmpty else {
            fatalError("No imageUrls available")
        }
        return photoUrlList[index]
    }
    
}
