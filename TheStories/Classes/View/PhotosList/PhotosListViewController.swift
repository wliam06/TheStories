//
//  PhotosListViewController.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

struct ImageViewModel {
    let image: UIImage
}

class PhotosListViewController: UIViewController, PhotosListView {
    var event: PhotosListEvent?

    @IBOutlet weak var collectionView: UICollectionView!

    private(set) var photosList = [Photo]()
    private(set) var images = [ImageViewModel]()

    private(set) var isLoading = true
    private(set) var position = 0
    private(set) var estimatedHeight: CGFloat = 0

    private(set) var searchViewController = UISearchController(searchResultsController: nil)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        // With photo object, first page and number of page
        event?.onRequestListPhotos(withPhoto: photosList, startPage: 0,
                                   perPage: Constant.numberOfPage, imageViewModel: images)

        configureCollectionView()
    }

    private func configureSearchBar() {
        self.navigationItem.titleView = searchViewController.searchBar
    }

    private func configureCollectionView() {
        // Customize UICollectionViewLayout
        let flowLayout: PinterestLayout = {
            if let layout = collectionView.collectionViewLayout as? PinterestLayout {
                return layout
            }

            let layout = PinterestLayout()
            collectionView.collectionViewLayout = layout

            return layout
        }()
        flowLayout.delegate = self

        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // Register cell
        collectionView.register(UINib(nibName: PhotoViewCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier())
    }

    // MARK: - View
    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel]) {
        collectionView.performBatchUpdates({
            var indexPath = [IndexPath]()
            var index = 0

            for row in position..<page {
                self.photosList.append(photos[index])
                self.images.append(imageViewModel[index])

                indexPath.append(IndexPath(row: row, section: 0))
                index += 1
            }

            collectionView.insertItems(at: indexPath)
        }, completion: nil)

        self.isLoading = false
        self.position = page
        self.collectionView.reloadData()
    }
}

extension PhotosListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = images[indexPath.item].image
        let height = image.size.height

        return height
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(),
                                                            for: indexPath) as? PhotoViewCell else {
            return UICollectionViewCell()
        }

        let image = images[indexPath.item].image
        print("image", image)
        cell.photoImageView.image = image

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentScrolled = (scrollView.contentOffset.y + UIScreen.main.bounds.size.height)
            / scrollView.contentSize.height
        if isLoading == false, percentScrolled >= 0.8 {
            isLoading = true

            event?.onRequestListPhotos(withPhoto: photosList, startPage: position,
                                       perPage: Constant.numberOfPage, imageViewModel: images)
        }
    }
}
