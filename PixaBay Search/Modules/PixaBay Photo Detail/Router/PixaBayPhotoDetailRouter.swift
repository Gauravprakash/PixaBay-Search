//
//  PixaBayPhotoDetailRouter.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit

final class PixaBayPhotoDetailRouter: PixaBayPhotoDetailRouterInput {
    
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
