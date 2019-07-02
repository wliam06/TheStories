//
//  SearchViewController.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchView {
    @IBOutlet weak var tableView: UITableView!

    var event: SearchViewEvent?
    var suggestion: [String] = ["Office", "Sunrise", "Rain", "Basket Ball", "Love"]

    fileprivate(set) var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search stories"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
