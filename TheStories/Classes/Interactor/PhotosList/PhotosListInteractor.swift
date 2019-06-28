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

    func requestListPhotos() {
        PhotosService().listPhotos(1, pageCount: 10) { [weak self] (response, error) in
            if let result = response {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: result, options: [])
                    let photos = try JSONDecoder().decode([Photo].self, from: jsonData)

                    self?.output?.foundListPhotos(withPhotos: photos)
                } catch {
                    debugPrint("err")
                }
            }
        }
    }
}
