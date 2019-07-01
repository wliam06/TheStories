//
//  ImageViewExtensions.swift
//  TheStories
//
//  Created by Wil Liam on 6/29/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL?) {
        guard let url = url else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
            guard let data = data else { return }

            let image = UIImage(data: data)

            DispatchQueue.main.async {
                self.image = image
            }
        }).resume()
    }
}
