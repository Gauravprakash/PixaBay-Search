//
//  PixaBaySearchViewController.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit

//MARK: ViewState
public enum ViewState: Equatable {
    case none
    case loading
    case error(String)
    case content
}


//MARK: PixaBaySearchViewController
final class PixaBaySearchViewController: UIViewController, PixaBaySearchViewInput, PixaBaySearchEventDelegate {
    
    var presenter: PixaBaySearchViewOutput!
    var viewState: ViewState = .none
    var pixaBaySearchViewModel: PixaBaySearchViewModel?
    var searchText = ""
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing = Constants.defaultSpacing
        let itemSize: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - spacing) - 2) / Constants.numberOfColumns
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.size.height ?? 0.0) + 100 + 160, width: Constants.screenWidth, height: view.frame.size.height - (navigationController?.navigationBar.frame.size.height ?? 0.0) + 100 + 160), collectionViewLayout: collectionViewLayout)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var tagsView:TagsView = {
        
        let frame = CGRect(x: view.frame.origin.x, y:(navigationController?.navigationBar.frame.size.height ?? 0.0) + 100, width: Constants.screenWidth, height: 160)
        let tagsView = TagsView(frame: frame)
        let titles = CoreDataManager.sharedManager.fetchAllTags()
        let tags = titles.map { button(with: $0) }
        tagsView.backgroundColor = .white
        tagsView.create(cloud: tags)
        return tagsView
    }()
    
    lazy var searchController: UISearchController = {
        let searchVC = SearchViewController()
        searchVC.searchDelegate = self
        let controller = UISearchController(searchResultsController: searchVC)
        if #available(iOS 11, *) {
            controller.obscuresBackgroundDuringPresentation = true
        } else {
            controller.dimsBackgroundDuringPresentation = true
        }
        controller.searchResultsUpdater = nil
        controller.searchBar.placeholder = Strings.placeholder
        controller.searchBar.delegate = searchVC
        return controller
    }()
    
    private func button(with title: String) -> UIButton {
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = title.size(withAttributes: attributes)

        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = size.height / 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height + 10.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        button.addTarget(self, action: #selector(loadTags), for: .touchUpInside)
        return button
    }
    
    @objc func loadTags(sender:UIButton){
        searchController.searchBar.text = sender.titleLabel?.text
    }
    
    //MARK: ViewController Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.title = Strings.pixabaySearchTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        configureCollectionView()
        configureSearchController()
        configureTagsView()
        
    }
    
    //MARK: configureTagsView
       private func configureTagsView() {
           view.addSubview(tagsView)
       }
    
    //MARK: configureSearchController
    private func configureSearchController() {
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.view
        }
        definesPresentationContext = true
    }
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperView()
        collectionView.register(PixaBayImageCell.self)
        collectionView.register(FooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
    
    // PixaBaySearchViewInput
    func changeViewState(_ state: ViewState) {
        viewState = state
        switch state {
        case .loading:
            if pixaBaySearchViewModel == nil {
                showSpinner()
            }
        case .content:
            hideSpinner()
        case .error(let message):
            hideSpinner()
            showAlert(title: Strings.error, message: message, retryAction: { [unowned self] in
                self.presenter.searchPixaBayPhotos(matching: self.searchText)
            })
        default:
            break
        }
    }
    
    //MARK: PixaBaySearchViewInput
    func displayPixaBaySearchImages(with viewModel: PixaBaySearchViewModel) {
        pixaBaySearchViewModel = viewModel
        collectionView.reloadData()
    }
    
    func insertPixaBaySearchImages(with viewModel: PixaBaySearchViewModel, at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            self.pixaBaySearchViewModel = viewModel
            self.collectionView.insertItems(at: indexPaths)
        })
    }
    
    func resetViews() {
        searchController.searchBar.text = nil
        pixaBaySearchViewModel = nil
        collectionView.reloadData()
    }
    
    //MARK: PixaBaySearchEventDelegate
    func didTapSearchBar(withText searchText: String) {
        searchController.isActive = false
        guard !searchText.isEmpty || searchText != self.searchText else { return }
        presenter.clearData()
        CoreDataManager.sharedManager.insertTag(name: searchText)
        tagsView.isHidden = true
        self.searchText = searchText
        searchController.searchBar.text = searchText
        ImageDownloader.shared.cancelAll()
        presenter.searchPixaBayPhotos(matching: searchText)
    }
    
    func showTagsView(value: Bool) {
        self.tagsView.isHidden = value
    }
    
}


//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension PixaBaySearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.pixaBaySearchViewModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PixaBayImageCell
        guard let viewModel = pixaBaySearchViewModel else {
            return cell
        }
        let imageURL = viewModel.imageUrlAt(indexPath.row)
        cell.configure(imageURL: imageURL, size: collectionViewLayout.itemSize, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = pixaBaySearchViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.photoCount - 1) else {
            return
        }
        presenter.searchPixaBayPhotos(matching: searchText)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = pixaBaySearchViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.photoCount - 1) else {
            return
        }
        let imageURL = viewModel.imageUrlAt(indexPath.row)
        ImageDownloader.shared.changeDownloadPriority(for: imageURL)
    }
    
    //MARK: UICollectionViewFooter
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewState == .loading && pixaBaySearchViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,  at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as FooterView
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectPhoto(at: indexPath.item)
    }
}


