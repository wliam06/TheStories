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
    private(set) var totalPage = 0
    private(set) var estimatedHeight: CGFloat = 0
    private(set) var position = 0

    private(set) var searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "The Stories"

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Stories"
        searchController.searchBar.becomeFirstResponder()
        navigationItem.searchController = searchController
        definesPresentationContext = true

        searchController.searchBar.delegate = self

        // With photo object, first page and number of page
        event?.onRequestListPhotos(startPage: 1, perPage: 30, imageViewModel: images)

        configureCollectionView()
    }

    private func configureCollectionView() {
        // Customize UICollectionViewLayout
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // Register cell
        collectionView.register(UINib(nibName: PhotoViewCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier())

        let customLayout = CustomLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
    }

    // MARK: - View
    func showListPhotos(withPhotos photos: [Photo], page: Int, imageViewModel: [ImageViewModel]) {
        collectionView.performBatchUpdates({
            var indexPath = [IndexPath]()
            var index = 0

            for row in totalPage..<page {
                self.photosList.append(photos[index])
                self.images.append(imageViewModel[index])

                indexPath.append(IndexPath(row: row, section: 0))
                index += 1
            }

            collectionView.insertItems(at: indexPath)
        }, completion: nil)

        self.isLoading = false
        self.totalPage = page
        self.position += 1

        self.collectionView.reloadData()
    }
}

extension PhotosListViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return images[indexPath.item].image.size
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch cell {
        case is PhotoViewCell:
            guard let cell = cell as? PhotoViewCell else { return }

            let image = images[indexPath.item].image
            cell.photoImageView.image = image
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(),
                                                  for: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentScrolled = (scrollView.contentOffset.y + UIScreen.main.bounds.size.height)
            / scrollView.contentSize.height
        if isLoading == false, percentScrolled >= 0.8 {
            isLoading = true

            event?.onRequestListPhotos(startPage: position,
                                       perPage: 30 + self.photosList.count,
                                       imageViewModel: images)
        }
    }
}

extension PhotosListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }

        event?.searchKeyword(keyword: keyword)

        searchController.searchBar.resignFirstResponder()
        view.endEditing(true)
    }
}
