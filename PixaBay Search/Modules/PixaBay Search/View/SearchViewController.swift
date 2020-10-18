//
//  SearchViewController.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import UIKit

protocol PixaBaySearchEventDelegate: AnyObject {
    func didTapSearchBar(withText searchText: String)
    func showTagsView(value:Bool)
}

final class SearchViewController: UIViewController, UISearchBarDelegate {

    weak var searchDelegate: PixaBaySearchEventDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.text = text
        searchBar.resignFirstResponder()
        searchDelegate?.didTapSearchBar(withText: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let _ = searchBar.text else {
                   return
        }
        searchDelegate?.showTagsView(value: true)
    }
}
