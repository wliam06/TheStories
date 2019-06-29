//
//  PhotoViewCell.swift
//  TheStories
//
//  Created by Wil Liam on 6/28/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoViewCell: UICollectionViewCell {
    var photoItem: Photo? {
        didSet {
            didSetPhotoItem()
        }
    }

    @IBOutlet weak var photoImageView: UIImageView!

    // MARK: - Reuse identifier
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

    static func cellSize(width: CGFloat) -> CGSize {
        let collectionWidth = width - 1
        return CGSize(width: collectionWidth / 2 - 1 / 2, height: collectionWidth / 2 + 85)
    }

    override func prepareForReuse() {
        self.photoImageView.image = nil

        super.prepareForReuse()
    }

    fileprivate func didSetPhotoItem() {
        guard let photo = photoItem else { return }

        photoImageView.image = UIImage.backgroundImage(withColor: .lightGray)
        photoImageView.af_cancelImageRequest()

        if let url = URL(string: photo.urls?.raw ?? "") {
            photoImageView.af_setImage(withURL: url, placeholderImage: photoImageView.image)
        }
    }
}
