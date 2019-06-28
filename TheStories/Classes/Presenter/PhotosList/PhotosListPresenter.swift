//
//  PhotosListPresenter.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

class PhotosListPresenter: PhotosListEvent, PhotosListInteractorOutput {
    weak var view: PhotosListView?
    let interactor: PhotosListInteractorInput
    let router: PhotosListRouter

    init(view: PhotosListView, interactor: PhotosListInteractorInput, router: PhotosListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
