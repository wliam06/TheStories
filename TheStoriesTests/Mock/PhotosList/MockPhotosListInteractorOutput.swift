//
//  MockPhotosListInteractorOutput.swift
//  TheStoriesTests
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockPhotosListInteractorOutput: PhotosListInteractorOutput {
    var invokedFoundListPhotos = false
    var invokedFoundListPhotosCount = 0
    var invokedFoundListPhotosParameters: (photos: [Photo], page: Int, imageModel: [ImageViewModel])?
    var invokedFoundListPhotosParametersList = [(photos: [Photo], page: Int, imageModel: [ImageViewModel])]()
    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel]) {
        invokedFoundListPhotos = true
        invokedFoundListPhotosCount += 1
        invokedFoundListPhotosParameters = (photos, page, imageModel)
        invokedFoundListPhotosParametersList.append((photos, page, imageModel))
    }
    var invokedFoundErrorRequest = false
    var invokedFoundErrorRequestCount = 0
    var invokedFoundErrorRequestParameters: (error: ErrorRespond, Void)?
    var invokedFoundErrorRequestParametersList = [(error: ErrorRespond, Void)]()
    func foundErrorRequest(error: ErrorRespond) {
        invokedFoundErrorRequest = true
        invokedFoundErrorRequestCount += 1
        invokedFoundErrorRequestParameters = (error, ())
        invokedFoundErrorRequestParametersList.append((error, ()))
    }
}
