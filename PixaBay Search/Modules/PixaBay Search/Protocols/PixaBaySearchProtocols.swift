//
//  PixaBaySearchProtocols.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation
import UIKit

//MARK: BaseViewInput

protocol BaseViewInput: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension BaseViewInput where Self: UIViewController {
    func showSpinner() {
        view.showSpinner()
    }
    
    func hideSpinner() {
        view.hideSpinner()
    }
}


//MARK: View
protocol PixaBaySearchViewInput: BaseViewInput {
    var presenter: PixaBaySearchViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func displayPixaBaySearchImages(with viewModel: PixaBaySearchViewModel)
    func insertPixaBaySearchImages(with viewModel: PixaBaySearchViewModel, at indexPaths: [IndexPath])
    func resetViews()
}

//MARK: Presenter
protocol PixaBaySearchModuleInput: AnyObject {
    var view: PixaBaySearchViewInput? { get set }
    var interactor: PixaBaySearchInteractorInput! { get set }
    var router: PixaBaySearchRouterInput! { get set }
}

protocol PixaBaySearchViewOutput: AnyObject {
    func searchPixaBayPhotos(matching imageName: String)
    var  isMoreDataAvailable: Bool { get }
    func clearData()
    func didSelectPhoto(at index: Int)
}

protocol PixaBaySearchInteractorOutput: AnyObject  {
    func pixabaySearchSuccess(_ pixabayPhotos: PixaBayPhotos)
    func pixabaySearchError(_ error: NetworkError)
}


//MARK: InteractorInput
protocol PixaBaySearchInteractorInput: AnyObject {
    var presenter: PixaBaySearchInteractorOutput? { get set }
    func loadPixaBayPhotos(matching imageName: String, pageNum: Int)
}

//MARK: Router
protocol PixaBaySearchRouterInput: AnyObject {
    func showPixaBayPhotoDetails(with imageUrl: URL)
}

