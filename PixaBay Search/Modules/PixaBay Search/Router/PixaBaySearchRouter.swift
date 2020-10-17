
//
//  PixaBaySearchRouter.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit


final class PixaBaySearchRouter: PixaBaySearchRouterInput {
   
    weak var viewController: UIViewController?
    
    func showPixaBayPhotoDetails(with imageUrl: URL) {
        let detailVC =  PixaBayPhotoDetailModuleBuilder().buildModule(with: imageUrl)
        viewController?.present(detailVC, animated: true)
    }
}
