//
//  SearchViewInteractorIO.swift
//  TheStories
//
//  Created by Wil Liam on 7/1/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol SearchViewInteractorInput: class {
    func requestSearchByKeyword(keyword: String, startPage: Int, perPage: Int)
}

protocol SearchViewInteractorOutput: class {
    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel])

    func foundErrorRequest(error: ErrorRespond)
}
