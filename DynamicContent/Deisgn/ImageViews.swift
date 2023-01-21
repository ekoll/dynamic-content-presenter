//
//  ImageViews.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

extension UIImageView {
    
    static func aspectFit(_ image: UIImage?) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit

        return imageView
    }

    static var hint: UIImageView {
        let imageView = aspectFit(.init(systemName: "info.circle"))
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.tintColor = .gray

        return imageView
    }
}
