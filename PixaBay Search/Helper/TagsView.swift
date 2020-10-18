//
//  TagsView.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation
import UIKit

class TagsView: UIView {

    // MARK: - Properties

    var offset: CGFloat = 5

    // MARK: - Public functions

    func create(cloud tags: [UIButton]) {
        var x = offset
        var y = offset
        for (index, tag) in tags.enumerated() {
            tag.frame = CGRect(x: x, y: y, width: tag.frame.width, height: tag.frame.height)
            x += tag.frame.width + offset

            let nextTag = index <= tags.count - 2 ? tags[index + 1] : tags[index]
            let nextTagWidth = nextTag.frame.width + offset

            if x + nextTagWidth > frame.width {
                x = offset
                y += tag.frame.height + offset
            }

            addSubview(tag)
        }
    }

}




