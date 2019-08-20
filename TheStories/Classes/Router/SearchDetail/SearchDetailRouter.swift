//
//  SearchDetailRouter.swift
//  TheStories
//
//  Created by William on 10/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class SearchDetailRouter: Router {
    var controller: UIViewController {
        let view = SearchDetailViewController()
        let interactor = SearchDetailInteractor()
        let presenter = SearchDetailPresenter(view: view, interactor: interactor, router: self)
        let navigationController = UINavigationController(rootViewController: view)

        view.event = presenter
        interactor.output = presenter

        return navigationController
    }
}
