//
//  Constant.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

enum Constant: String {
    case baseUrl = "https://api.unsplash.com"
    case clientID = "Client-ID d8a272c480b258b875d82f4062d6c52e4ae7f4b4656add778d71e9b638b2f8be"
    case applicationJson = "application/json"
    case apiVersion = "v1"

    // Services
    case query
    case page
    case perPage = "per_page"
    case orderBy = "order_by"
}
