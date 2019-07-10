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

    // MARK: - Initialize
    init(view: SearchView, interactor: SearchViewInteractorInput, router: SearchViewRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // Input
    func onSearch(keyword: String, startPage: Int, perPage: Int) {
        interactor.requestSearchByKeyword(keyword: keyword, startPage: startPage, perPage: perPage)
    }

    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel]) {
        view?.showListPhotos(withPhotos: photos, page: page, imageViewModel: imageModel)
    }

    func searchTypeDidTapped(viewController: SearchViewController, selectedType: String) {
        guard let navigationController = viewController.navigationController else { return }
        router.pushToSearchDetailByType(navigationController: navigationController,
                                        searchTyped: selectedType)
    }

    // Output
    func foundErrorRequest(error: ErrorRespond) {
        // Error View
        view?.showErrorRequest(error: error)
    }
}
