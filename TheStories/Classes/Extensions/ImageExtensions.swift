//
//  ImageExtensions.swift
//  TheStories
//
//  Created by Wil Liam on 6/29/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImage {
    static func backgroundImage(withColor color: UIColor) -> UIImage? {
        return backgroundImage(withColor: color, size: CGSize(width: 40, height: 40))
    }

    static func backgroundImage(withColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        color.setFill()

        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }

    public func setHeight(forWidth width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        let rect = AVMakeRect(
            aspectRatio: size,
            insideRect: boundingRect
        )

        return rect.size.height
    }
}
