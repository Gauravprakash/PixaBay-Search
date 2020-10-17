//
//  PixaBaySearchModuleBuilder.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit


protocol PixaBayModuleBuilder: AnyObject {
    func buildModule() -> PixaBaySearchViewController
}


final class PixaBaySearchModuleBuilder: PixaBayModuleBuilder {

func buildModule() -> PixaBaySearchViewController {
    let pixabayViewController = PixaBaySearchViewController()
    let presenter = PixaBaySearchPresenter()
    let network = NetworkAPIClient()
    let interactor = PixaBaySearchIneractor(network: network)
    let router = PixaBaySearchRouter()
    
    presenter.view = pixabayViewController
    presenter.interactor = interactor
    presenter.router = router
    interactor.presenter = presenter
    pixabayViewController.presenter = presenter
    router.viewController = pixabayViewController
    
    return pixabayViewController
}
}
