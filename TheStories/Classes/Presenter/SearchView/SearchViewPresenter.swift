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
}
