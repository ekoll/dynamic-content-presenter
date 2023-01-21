//
//  TextFields.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

extension UITextField {
    
    static var standard: UITextField {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        
        return textField
    }
}
