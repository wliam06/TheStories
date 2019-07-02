//
//  AlertView.swift
//  TheStories
//
//  Created by William on 02/07/19.
//  Copyright © 2019 William. All rights reserved.
//

import UIKit

class AlertView: UIAlertController {
    override var preferredStyle: UIAlertController.Style {
        return .alert
    }

    // MARK: - Initialize
    init(title: String?, message: String) {
        super.init(nibName: nil, bundle: nil)

        self.title = title
        self.message = message
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configureAlert() {
        let okAction = UIAlertAction(title: title, style: .cancel, handler: nil)

        self.addAction(okAction)
    }
}
