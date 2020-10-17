//
//  PixaBayPhotoDetailProtocols.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit


protocol PixaBayPhotoDetailViewInput: BaseViewInput {
    func renderView(with imageUrl: URL)
}

protocol PixaBayPhotoDetailViewOutput: AnyObject {
   func didTapClose()
   func onViewDidLoad()
}

protocol PixaBayPhotoDetailModuleInput: AnyObject {
    var view: PixaBayPhotoDetailViewInput? { get set }
    var router: PixaBayPhotoDetailRouterInput! { get set }
}

protocol PixaBayPhotoDetailInteractorInput: AnyObject {
    
}

protocol PixaBayPhotoDetailInteractorOutput: AnyObject {
    
}

protocol PixaBayPhotoDetailRouterInput: AnyObject {
    func dismiss()
}
