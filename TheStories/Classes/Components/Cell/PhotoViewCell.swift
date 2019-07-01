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
    var photo: Photo? {
        didSet {
            didSetPhotoImage()
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

    private func didSetPhotoImage() {
        guard let photo = photo else { return }

        photoImageView.af_cancelImageRequest()
        photoImageView.image = UIImage.backgroundImage(withColor: .liteGrey)

        if let url = URL(string: photo.urls?.regular ?? "") {
            photoImageView.af_setImage(withURL: url, placeholderImage: photoImageView.image)
        }
    }
}
