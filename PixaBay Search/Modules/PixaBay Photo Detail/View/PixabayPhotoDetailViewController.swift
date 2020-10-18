//
//  PixaBayPhotoDetailViewController.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit

final class PixaBayPhotoDetailViewController: UIViewController, PixaBayPhotoDetailViewInput {

    var presenter: PixaBayPhotoDetailViewOutput!
    var arrayListing:[URL] = []
    fileprivate enum LayoutConstants {
        static let buttonWidth: CGFloat = 50
        static let rightpadding: CGFloat = -20
        static let topPadding: CGFloat = 50
    }
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
         let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: Constants.screenWidth, height: Constants.screenWidth)
         layout.scrollDirection = .horizontal
         return layout
     }()
    lazy var collectionView: UICollectionView = {
           let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
           collectionView.backgroundColor = .white
           collectionView.dataSource = self
           collectionView.delegate = self
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           return collectionView
       }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.setTitle(Strings.close, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.onViewDidLoad()
    }
    
    private func setupViews() {
        configureCollectionView()
        view.addSubview(closeButton)
        setupConstraints()
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperView()
        collectionView.register(PixaBayImageCell.self)
    }
    
    
    
    fileprivate func setupConstraints() {
        collectionView.centerInSuperView()
        collectionView.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.rightpadding).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.topPadding).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth).isActive = true
    }
    
    func renderView(with imageUrl: [URL]) {
        self.arrayListing = imageUrl
        self.collectionView.reloadData()
    }
    
    @objc func didTapCloseButton(_ sender: UIButton) {
        presenter.didTapClose()
    }
}

extension PixaBayPhotoDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.arrayListing.count>0 ? self.arrayListing.count : 0
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath) as PixaBayImageCell
    let imageURL = self.arrayListing[indexPath.item]
    cell.configure(imageURL: imageURL, size: collectionViewLayout.itemSize, indexPath: indexPath)
    return cell
}
    
}
