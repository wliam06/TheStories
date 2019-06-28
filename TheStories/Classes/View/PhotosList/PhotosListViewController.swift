//
//  PhotosListViewController.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController, PhotosListView {
    @IBOutlet weak var collectionView: UICollectionView!

    var event: PhotosListEvent?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
