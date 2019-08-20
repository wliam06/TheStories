//
//  MockSearchView.swift
//  TheStoriesTests
//
//  Created by William on 02/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockSearchView: SearchView {
    var invokedShowErrorRequest = false
    var invokedShowErrorRequestCount = 0
    var invokedShowErrorRequestParameters: (error: ErrorRespond, Void)?
    var invokedShowErrorRequestParametersList = [(error: ErrorRespond, Void)]()
    func showErrorRequest(error: ErrorRespond) {
        invokedShowErrorRequest = true
        invokedShowErrorRequestCount += 1
        invokedShowErrorRequestParameters = (error, ())
        invokedShowErrorRequestParametersList.append((error, ()))
    }
    var invokedShowListPhotos = false
    var invokedShowListPhotosCount = 0
    var invokedShowListPhotosParameters: (photos: [Photo], page: Int, imageViewModel: [ImageViewModel])?
    var invokedShowListPhotosParametersList = [(photos: [Photo], page: Int, imageViewModel: [ImageViewModel])]()
    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel]) {
        invokedShowListPhotos = true
        invokedShowListPhotosCount += 1
        invokedShowListPhotosParameters = (photos, page, imageViewModel)
        invokedShowListPhotosParametersList.append((photos, page, imageViewModel))
    }
}
