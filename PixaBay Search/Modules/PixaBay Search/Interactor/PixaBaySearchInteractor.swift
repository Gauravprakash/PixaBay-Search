//
//  PixaBaySearchInteractor.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//
import Foundation

final class PixaBaySearchIneractor: PixaBaySearchInteractorInput {
    
    let network: NetworkService
    weak var presenter: PixaBaySearchInteractorOutput?
    
    init(network: NetworkService) {
        self.network = network
    }
    
    //MARK: Load PixaBay images for searched text from the network
    func loadPixaBayPhotos(matching imageName: String, pageNum: Int) {
        let endPoint = PixaBaySearchAPI.search(query: imageName, page: pageNum)
        network.dataRequest(endPoint, objectType: PixaBayPhotos.self) { [weak self] (result: Result<PixaBayPhotos, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.pixabaySearchSuccess(response)
            case let .failure(error):
                self.presenter?.pixabaySearchError(error)
            }
        }
    }
}
