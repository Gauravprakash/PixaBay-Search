//
//  PixaBaySearchPresenter.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation


final class PixaBaySearchPresenter: PixaBaySearchModuleInput, PixaBaySearchViewOutput, PixaBaySearchInteractorOutput {
    
    weak var view: PixaBaySearchViewInput?
    var interactor: PixaBaySearchInteractorInput!
    var router: PixaBaySearchRouterInput!
    
    var pixabaySearchViewModel: PixaBaySearchViewModel!
    
    var pageNum = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    var totalPages = Constants.defaultPageNum
    var totalDisplayingData =  Constants.defaultPageNum
    
    var isMoreDataAvailable: Bool {
        guard totalCount != Constants.defaultTotalCount else {
            return true
        }
        return totalDisplayingData < totalCount
    }
    
    //MARK: PixaBaySearchViewOutput
    func searchPixaBayPhotos(matching imageName: String) {
        guard isMoreDataAvailable else { return }
        view?.changeViewState(.loading)
        pageNum += 1
        interactor.loadPixaBayPhotos(matching: imageName, pageNum: pageNum)
    }
    
    func didSelectPhoto(at index: Int) {
        var imageArray = [URL]()
        for i in index..<pixabaySearchViewModel.photoUrlList.count{
            imageArray.append(pixabaySearchViewModel.photoUrlList[i])
        }
        router.showPixaBayPhotoDetails(with: imageArray)
    }
    
    //MARK: Photo Search Success
   
    fileprivate func insertMorePixaBayPhotos(with pixabayPhotoUrlList: [URL]) {
        let previousCount = totalDisplayingData
        totalDisplayingData += pixabayPhotoUrlList.count
        pixabaySearchViewModel.addMorePhotoUrls(pixabayPhotoUrlList)
        let indexPaths: [IndexPath] = (previousCount..<totalDisplayingData).map {
            return IndexPath(item: $0, section: 0)
        }
        DispatchQueue.main.async { [unowned self] in
            self.view?.insertPixaBaySearchImages(with: self.pixabaySearchViewModel, at: indexPaths)
            self.view?.changeViewState(.content)
        }
    }
    
    func pixabaySearchSuccess(_ pixabayPhotos: PixaBayPhotos) {
        let pixabayPhotoUrlList = buildPixaBayPhotoUrlList(from: pixabayPhotos.hits ?? [])
        guard !pixabayPhotoUrlList.isEmpty else {
            return
        }
        
        if totalCount == Constants.defaultTotalCount {
            totalDisplayingData += pixabayPhotos.hits?.count ?? 0
            pixabaySearchViewModel = PixaBaySearchViewModel(photoUrlList: pixabayPhotoUrlList)
            totalCount = pixabayPhotos.total ?? 0
            DispatchQueue.main.async { [unowned self] in
                self.view?.displayPixaBaySearchImages(with: self.pixabaySearchViewModel)
                self.view?.changeViewState(.content)
            }
        } else {
            insertMorePixaBayPhotos(with: pixabayPhotoUrlList)
        }
    }
    
    
    //MARK:  PixaBaySearchInteractorOutput
    func pixabaySearchError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.error(error.description))
        }
    }
    
    //MARK: Private Methods
    func buildPixaBayPhotoUrlList(from photos: [PixaBayPhoto]) -> [URL] {
        let pixabayPhotoUrlList = photos.compactMap { (photo) -> URL? in
            let url = photo.webformatURL ?? ""
            guard let imageUrl = URL(string: url) else {
                return nil
            }
            return imageUrl
        }
        return pixabayPhotoUrlList
    }
    
    func clearData() {
        pageNum = Constants.defaultPageNum
        totalCount = Constants.defaultTotalCount
        totalPages = Constants.defaultTotalCount
        pixabaySearchViewModel = nil
        view?.resetViews()
        view?.changeViewState(.none)
    }
}
