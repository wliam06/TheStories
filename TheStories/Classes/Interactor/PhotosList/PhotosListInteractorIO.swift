//
//  PhotosListInteractorIO.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol PhotosListInteractorInput: class {
    func requestListPhotos(startPage: Int, perPage: Int, selectedBy: String)
}

protocol PhotosListInteractorOutput: class {
    func foundListPhotos(withPhotos photos: [Photo], page: Int, imageModel: [ImageViewModel])

    func foundErrorRequest(error: ErrorRespond)
}
