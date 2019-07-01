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
        
    }
}
