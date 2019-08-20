//
//  Router.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

struct ParentRouter {
    var navigationController = UINavigationController(rootViewController: UIViewController())
}

protocol Router {
    var controller: UIViewController { get }
}
