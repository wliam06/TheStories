//
//  HeaderSearchView.swift
//  TheStories
//
//  Created by William on 08/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class HeaderSearchView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    let searchType = ["Style", "Science & Tech", "Auto", "Music", "Food",
                      "Comics", "Travel", "Gaming", "Beauty", "TV & Movies",
                      "Sports", "Animals"]

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadNib()
    }

    private func loadNib() {
        Bundle.main.loadNibNamed(String(describing: HeaderSearchView.self), owner: self, options: nil)

        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(content)

        configureCollection()
    }

    private func configureCollection() {
        collectionView.register(UINib(nibName: SearchTypeCell.reuseIdentifier(), bundle: nil),
                                forCellWithReuseIdentifier: SearchTypeCell.reuseIdentifier())
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}

extension HeaderSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchType.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchTypeCell.reuseIdentifier(),
                                 for: indexPath) as? SearchTypeCell else {
                                    return UICollectionViewCell()
        }

        cell.searchTitle = searchType[indexPath.row]
        return cell
    }
}

extension HeaderSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let cell: SearchTypeCell = Bundle.main.loadNibNamed(SearchTypeCell.reuseIdentifier(),
                          owner: self, options: nil)?.first as? SearchTypeCell else {
            return CGSize.zero
        }

        cell.searchTitle = searchType[indexPath.row]
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
    }
}
