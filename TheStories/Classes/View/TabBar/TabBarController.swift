//
//  TabBarController.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    private(set) var photoListView: UIViewController!
    private(set) var searchView: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        photoListView = PhotosListRouter().controller
        photoListView.tabBarItem = UITabBarItem(title: "Photo", image: nil, tag: 1)

        searchView = SearchViewRouter().controller
        searchView.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 2)

        let tabBarList: [UIViewController] = [photoListView, searchView]
        viewControllers = tabBarList
    }
}
