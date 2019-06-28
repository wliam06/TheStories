//
//  PhotosListInteractorIO.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

protocol PhotosListInteractorInput: class {
    func requestListPhotos()
}

protocol PhotosListInteractorOutput: class {
    func foundListPhotos(withPhotos photos: [Photo])
}
