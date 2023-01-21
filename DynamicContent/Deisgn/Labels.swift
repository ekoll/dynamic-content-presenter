//
//  Labels.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

extension UILabel {
    
    static var base: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }
    
    static var title: UILabel {
        let label = UILabel.base
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        return label
    }

    static var standard: UILabel {
        let label = UILabel.base
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return label
    }
    
    static var hint: UILabel {
        let label = UILabel.base
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0

        return label
    }
}
