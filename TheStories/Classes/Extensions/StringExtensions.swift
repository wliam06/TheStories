//
//  StringExtensions.swift
//  TheStories
//
//  Created by William on 08/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

extension String {
    func textWidth(widthConstraintHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
}
