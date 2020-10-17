//
//  PixaBayDetailModuleBuilder.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//
import Foundation

protocol PixaBayDetailModuleBuilder {
    func buildModule(with imageUrl: URL) -> PixaBayPhotoDetailViewController
}

final class PixaBayPhotoDetailModuleBuilder: PixaBayDetailModuleBuilder {
    
    func buildModule(with imageUrl: URL) -> PixaBayPhotoDetailViewController {
        
        let detailViewController = PixaBayPhotoDetailViewController()
        let presenter = PixaBayPhotoDetailPresenter(imageUrl: imageUrl)
        let router = PixaBayPhotoDetailRouter()
        
        presenter.view = detailViewController
        presenter.router = router
        
        detailViewController.presenter = presenter
        router.viewController = detailViewController
        
        return detailViewController
    }
}
