//
//  PhotosListRouter.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class PhotosListRouter: Router {
    var controller: UIViewController {
        let view = PhotosListViewController()
        let interactor = PhotosListInteractor()
        let presenter = PhotosListPresenter(view: view, interactor: interactor, router: self)

        let navigationController = UINavigationController(rootViewController: view)

        view.event = presenter
        interactor.output = presenter

        return navigationController
    }
}
