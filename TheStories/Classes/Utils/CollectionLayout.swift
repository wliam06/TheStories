//
//  CollectionLayout.swift
//  TheStories
//
//  Created by Wil Liam on 6/29/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

protocol CollectionLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView,
                        sizeForItemAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat
}

class CollectionLayout: UICollectionViewLayout {
    weak var delegate: CollectionLayoutDelegate?

    private var cache = [CollectionLayoutAttribute]()
    private var contentHeight: CGFloat = 0
    public var cellPadding: CGFloat = 1 / UIScreen.main.scale
    public var numberOfColumns: Int = 1

    override var collectionView: UICollectionView {
        return super.collectionView ?? UICollectionView()
    }

    private var contentWidth: CGFloat {
        let bounds = collectionView.bounds
        let insets = collectionView.contentInset

        return bounds.width - insets.left - insets.right
    }

    private var numberOfSections: Int {
        return collectionView.numberOfSections
    }

    private func numberOfItems(inSection section: Int) -> Int {
        return collectionView.numberOfItems(inSection: section)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func invalidateLayout() {
        cache.removeAll()
        contentHeight = 0

        super.invalidateLayout()
    }

    override func prepare() {
        guard cache.isEmpty, collectionView.numberOfSections > 0 else {
            return
        }

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let cellWidth = columnWidth - (cellPadding * 2)

        var xOffsets = [CGFloat]()

        for column in 0..<numberOfColumns {
            xOffsets.append(CGFloat(column) * columnWidth)
        }

        for section in 0..<numberOfSections {
            let numberOfItems = self.numberOfItems(inSection: section)

            var yOffsets = [CGFloat](repeating: contentHeight, count: numberOfColumns)

            for item in 0..<numberOfItems {
                let indexPath = IndexPath(item: item, section: section)
                var column = yOffsets.firstIndex(of: yOffsets.min() ?? 0) ?? 0
                let imageHeight = delegate?.collectionView(collectionView: collectionView,
                                                           sizeForItemAtIndexPath: indexPath, width: cellWidth) ?? 0
                let cellContentHeight = imageHeight * columnWidth / cellWidth

                let cellHeight = cellPadding + cellContentHeight

                let frame = CGRect(
                    x: xOffsets[column],
                    y: yOffsets[column],
                    width: columnWidth,
                    height: cellHeight
                )

                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = CollectionLayoutAttribute (
                    forCellWith: indexPath
                )
                attributes.frame = insetFrame
                attributes.imageHeight = imageHeight
                cache.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)

                yOffsets[column] = yOffsets[column] + cellHeight
                column = column < (numberOfColumns - 1) ? column + 1 : 0
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [CollectionLayoutAttribute]()

        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
