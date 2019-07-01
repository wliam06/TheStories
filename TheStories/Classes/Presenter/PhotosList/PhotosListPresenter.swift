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

    // MARK: - Initializer
    init(view: PhotosListView, interactor: PhotosListInteractorInput, router: PhotosListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // Input
    func onRequestListPhotos(startPage: Int, perPage: Int, imageViewModel: [ImageViewModel]) {
        interactor.requestListPhotos(startPage: startPage, perPage: perPage, imageViewModel: imageViewModel)
    }

    // output
    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel]) {

        view?.showListPhotos(withPhotos: photos, page: page, imageViewModel: imageModel)
    }

    func foundErrorRequest(error: ErrorRespond) {
        // Error View
    }
}
