//
//  SearchTypeCell.swift
//  TheStories
//
//  Created by William on 08/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class SearchTypeCell: UICollectionViewCell {
    @IBOutlet weak var searchLabel: UILabel!

    static let searchLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)

    var searchTitle: String? {
        didSet {
            didSetSearchTitle()
        }
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.liteGrey.cgColor
    }

    private func didSetSearchTitle() {
        guard let title = searchTitle else { return }

        searchLabel.text = title
    }
}
