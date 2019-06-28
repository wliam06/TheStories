//
//  ImageURL.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

struct ImageURL: Codable {
    let raw: String = ""
    let full: String = ""
    let regular: String = ""
    let small: String = ""
    let thumb: String = ""

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
