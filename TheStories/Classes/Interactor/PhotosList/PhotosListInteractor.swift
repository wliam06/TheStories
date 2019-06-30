//
//  PhotosListInteractor.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

class PhotosListInteractor: PhotosListInteractorInput {
    weak var output: PhotosListInteractorOutput?

    // Request photos list
    func requestListPhotos(withPhotos photos: [Photo], startPage: Int, perPage: Int) {
        PhotosService().listPhotos(pageNum: startPage, perPage: perPage) { [weak self] (response, error) in
            if let error = error {
                self?.output?.foundErrorRequest(error: error)
                return
            }
    
            var photos = photos

            guard let result = response else {
                self?.output?.foundListPhotos(withPhotos: photos, page: 0)
                return
            }

            // Added new item
            for data in result {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let photo = try JSONDecoder().decode(Photo.self, from: jsonData)

                    photos.append(photo)
                } catch {
                    debugPrint("Data cannot be converted")
                }
            }

            self?.output?.foundListPhotos(withPhotos: photos, page: startPage + perPage)
        }
    }
}
