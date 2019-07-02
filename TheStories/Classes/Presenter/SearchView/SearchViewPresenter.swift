//
//  SearchViewPresenter.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

class SearchViewPresenter: SearchViewEvent, SearchViewInteractorOutput {
    weak var view: SearchView?
    let interactor: SearchViewInteractorInput
    let router: SearchViewRouter

    init(view: SearchView, interactor: SearchViewInteractorInput, router: SearchViewRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func onSearch(keyword: String, startPage: Int, perPage: Int) {
        interactor.requestSearchByKeyword(keyword: keyword, startPage: startPage, perPage: perPage)
    }

    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel]) {
        view?.showListPhotos(withPhotos: photos, page: page, imageViewModel: imageModel)
    }

    func foundErrorRequest(error: ErrorRespond) {
        // Error View
    }
}
