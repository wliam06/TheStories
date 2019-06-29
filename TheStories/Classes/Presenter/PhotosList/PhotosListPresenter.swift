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
//    func onRequestListPhotos(withPageNum pageNum: Int) {
//        interactor.requestListPhotos(withPageNum: pageNum)
//    }

    func onRequestListPhotos(withPhoto photos: [Photo], withPageNum pageNum: Int) {
        interactor.requestListPhotos(withPhotos: photos, pageNum: pageNum)
    }

    // output
//    func foundListPhotos(withPhotos photos: [Photo], nextPage: Int) {
//        view?.showListPhotos(withPhotos: photos, page: nextPage)
//    }
    func foundListPhotos(withPhotos photos: [Photo], page: Int) {
        view?.showListPhotos(withPhotos: photos, page: page)
    }

    func foundErrorRequest(error: ErrorRespond) {
        // Error View
    }
}
