//
//  PhotosListViewController.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController, PhotosListView {
    var event: PhotosListEvent?

    @IBOutlet weak var collectionView: UICollectionView!

    private(set) var photosList = [Photo]()
    private(set) var isLoading = true
    private(set) var position = 0
    private(set) var estimatedHeight: CGFloat = 0

    private(set) var searchViewController = UISearchController(searchResultsController: nil)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        // With photo object, first page and number of page
        event?.onRequestListPhotos(withPhoto: photosList, startPage: 0, perPage: Constant.numberOfPage)

        configureCollectionView()
    }

    private func configureSearchBar() {
        self.navigationItem.titleView = searchViewController.searchBar
    }

    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 5, bottom: 49, right: 5)
        let layout: CollectionLayout = {
            if let layout = collectionView.collectionViewLayout as? CollectionLayout {
                return layout
            }

            let layout = CollectionLayout()

            collectionView.collectionViewLayout = layout

            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 1
        layout.numberOfColumns = 2

        // Register cell
        collectionView.register(UINib(nibName: PhotoViewCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier())
    }

    // MARK: - View
    func showListPhotos(withPhotos photos: [Photo], page: Int) {
        collectionView.performBatchUpdates({
            var indexPath = [IndexPath]()
            var index = 0

            for row in position..<page {
                self.photosList.append(photos[index])

                indexPath.append(IndexPath(row: row, section: 0))
                index += 1
            }

            collectionView.insertItems(at: indexPath)
        }, completion: nil)

        self.isLoading = false
        self.position = page
    }
}

// MARK: - CollectionLayoutDelegate
extension PhotosListViewController: CollectionLayoutDelegate {
    func collectionView(collectionView: UICollectionView,
                        sizeForItemAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(),
                                                            for: indexPath) as? PhotoViewCell else {
                                                                return 0
        }

        debugPrint("width", width)
        if let cellImageView = cell.photoImageView,
            let image = cellImageView.image {

            return image.setHeight(forWidth: width)
        } else {
            return 0
        }

        // 2
//        var estimatedHeight: CGFloat = (CGFloat(width) * ratio)

//            let width = imagePhoto.width
//            let height = imagePhoto.height
//
//            let ratio = CGFloat(height / width)
//        for index in 0..<photosList.count {
//            let width = photosList[index].width
//            let height = photosList[index].height
//
//            let ratio = (collectionView.frame.size.width / 2) * CGFloat(height / width)
//
//            if let cellImageView = cell.photoImageView, let image = cellImageView.image {
//                let ration = image.ratioImage(image: image, scaledWidth: collectionView.frame.size.width / 2)
//                debugPrint("ration", ration)
//            }
//        }
//        return 200
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosList.count
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch cell {
        case is PhotoViewCell:
            guard let cell = cell as? PhotoViewCell else { return }
            cell.photoItem = photosList[indexPath.row]
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(), for: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentScrolled = (scrollView.contentOffset.y + UIScreen.main.bounds.size.height)
            / scrollView.contentSize.height
        if isLoading == false, percentScrolled >= 0.8 {
            isLoading = true

            debugPrint("withPosition", position)
            event?.onRequestListPhotos(withPhoto: photosList, startPage: position, perPage: Constant.numberOfPage)
        }
    }
}
