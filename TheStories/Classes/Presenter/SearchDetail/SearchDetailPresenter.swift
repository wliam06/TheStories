//
//  SearchDetailPresenter.swift
//  TheStories
//
//  Created by William on 10/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

class SearchDetailPresenter: SearchDetailEvent, SearchDetailInteractorOutput {
    weak var view: SearchDetailView?
    let interactor: SearchDetailInteractorInput
    let router: SearchDetailRouter

    init(view: SearchDetailView, interactor: SearchDetailInteractorInput, router: SearchDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
