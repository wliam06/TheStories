//
//  CollectionLayoutAttribute.swift
//  TheStories
//
//  Created by Wil Liam on 6/29/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class CollectionLayoutAttribute: UICollectionViewLayoutAttributes {
    public var imageHeight: CGFloat = 0

    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? CollectionLayoutAttribute else {
            return 0
        }

        copy.imageHeight = imageHeight

        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CollectionLayoutAttribute {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
