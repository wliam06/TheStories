//
//  Photo.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

struct Photo: Codable, Equatable {
    let id: String = ""
    let createdAt: String = ""
    let updatedAt: String = ""
    let width: String = ""
    let height: String = ""
    let urls: ImageURL?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width
        case height
        case urls
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.createdAt == rhs.createdAt
    }
}
