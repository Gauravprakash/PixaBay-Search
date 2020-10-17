//
//  ApplicationRouter.swift
//  PixaBaySearchApp
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit

final public class AppConfigurator {
    
    @discardableResult
    func configureRootViewController(inWindow window: UIWindow?) -> Bool {
        let pixabaySearchViewController = PixaBaySearchModuleBuilder().buildModule()
        let navigationController = UINavigationController(rootViewController: pixabaySearchViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
