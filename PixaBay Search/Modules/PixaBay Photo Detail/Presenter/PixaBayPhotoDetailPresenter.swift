//
//   PixaBayPhotoDetailPresenter.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation

final class PixaBayPhotoDetailPresenter: PixaBayPhotoDetailModuleInput, PixaBayPhotoDetailViewOutput {
    
    var view: PixaBayPhotoDetailViewInput?
    var router: PixaBayPhotoDetailRouterInput!
    
    var imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
    
    func onViewDidLoad() {
        self.view?.showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.renderView(with: self.imageUrl)
            self.view?.hideSpinner()
        }
    }
    
    func didTapClose() {
        router.dismiss()
    }
}
