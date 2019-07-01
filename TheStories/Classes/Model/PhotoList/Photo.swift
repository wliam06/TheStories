//
//  Photo.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

struct Photo: Codable, Equatable {
    var id: String
    var urls: ImageURL?

    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.urls = try container.decodeIfPresent(ImageURL.self, forKey: .urls)
    }

    func encode(to encode: Encoder) throws {
        var container = encode.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(urls, forKey: .urls)
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
