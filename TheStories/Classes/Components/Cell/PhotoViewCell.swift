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

    override func awakeFromNib() {
        super.awakeFromNib()

        photoImageView.image = UIImage.backgroundImage(withColor: .liteGrey)
    }

    // Collection layout attributes
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        if let attributes = layoutAttributes as? CollectionLayoutAttribute {
            photoImageView.frame.size.height = attributes.imageHeight
        }
    }

    fileprivate func didSetPhotoItem() {
        guard let photo = photoItem else { return }

        photoImageView.af_cancelImageRequest()
        photoImageView.image = UIImage.backgroundImage(withColor: .liteGrey)

        if let url = URL(string: photo.urls?.regular ?? "") {
            photoImageView.af_setImage(withURL: url, placeholderImage: photoImageView.image)
        }
    }
}
