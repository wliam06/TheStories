//
//  MockSearchViewInteractorInput.swift
//  TheStoriesTests
//
//  Created by William on 02/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import XCTest

@testable import TheStories
class MockSearchViewInteractorInput: SearchViewInteractorInput {
    var invokedRequestSearchByKeyword = false
    var invokedRequestSearchByKeywordCount = 0
    var invokedRequestSearchByKeywordParameters: (keyword: String, startPage: Int, perPage: Int)?
    var invokedRequestSearchByKeywordParametersList = [(keyword: String, startPage: Int, perPage: Int)]()
    func requestSearchByKeyword(keyword: String, startPage: Int, perPage: Int) {
        invokedRequestSearchByKeyword = true
        invokedRequestSearchByKeywordCount += 1
        invokedRequestSearchByKeywordParameters = (keyword, startPage, perPage)
        invokedRequestSearchByKeywordParametersList.append((keyword, startPage, perPage))
    }
}
