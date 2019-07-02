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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    private(set) var photosList = [Photo]()
    private(set) var images = [ImageViewModel]()

    private(set) var isLoading = true
    private(set) var totalPage = 0
    private(set) var estimatedHeight: CGFloat = 0
    private(set) var position = 0

    private(set) var selectedIndex = 0
    private(set) var selectedTitle = ""

    private(set) var searchController = UISearchController(searchResultsController: nil)

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        activityIndicator.startAnimating()
        activityIndicator.isHidden = false

        self.view.backgroundColor = .whiteGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()

        let index = segmentControl.selectedSegmentIndex
        if let title = segmentControl.titleForSegment(at: index), index == 0 {
            selectedTitle = title.lowercased()

            event?.onRequestListPhotos(startPage: 1, perPage: 30, selectedType: title)
        }
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

        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true

        self.isLoading = false
        self.totalPage = page
        self.position += 1

        self.collectionView.reloadData()
    }

    private func cleanData() {
        if images.count > 0 {
            debugPrint("Cleaning data...")
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false

            self.images = [ImageViewModel]()
            self.photosList = [Photo]()
            self.totalPage = 0
            self.position = 0
            self.isLoading = true

            collectionView.reloadData()
        }
    }

    // MARK: - Action
    @IBAction func segmentControlDidClicked(_ sender: Any) {
        selectedIndex = segmentControl.selectedSegmentIndex

        switch segmentControl.selectedSegmentIndex {
        case 0:
            guard let title = segmentControl.titleForSegment(at: selectedIndex) else {
                break
            }

            cleanData()

            selectedTitle = title.lowercased()
            event?.onRequestListPhotos(startPage: 1, perPage: 30, selectedType: title)
        case 1:
            guard let title = segmentControl.titleForSegment(at: selectedIndex) else {
                break
            }

            cleanData()
            selectedTitle = title.lowercased()

            event?.onRequestListPhotos(startPage: 1, perPage: 30, selectedType: title)
        default:
            print("No selected")
        }
    }
}

extension PhotosListViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return images[indexPath.item].image.size
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
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
                                       selectedType: selectedTitle)
        }
    }
}
