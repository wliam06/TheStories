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

    private(set) var photo = [Photo]()
    private(set) var position = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        event?.onRequestListPhotos()

        configureCollectionView()
    }

    private func configureCollectionView() {
        // Register cell
        collectionView.register(UINib(nibName: PhotoViewCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier())
    }

    // View
    func showListPhotos(withPhotos photos: [Photo]) {
        collectionView.performBatchUpdates({
            var indexPath = [IndexPath]()
            var index = 0

            for row in position..<10 {
                self.photo.append(photos[index])

                indexPath.append(IndexPath(row: row, section: 0))
            }
            collectionView.insertItems(at: indexPath)
        }, completion: nil)
    }
}

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photo.count
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        switch cell {
        case is PhotoViewCell:
            guard let cell = cell as? PhotoViewCell else { return }
            cell.photoItem = photo[indexPath.row]
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier(), for: indexPath)
    }
}

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PhotoViewCell.cellSize(width: collectionView.frame.size.width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
