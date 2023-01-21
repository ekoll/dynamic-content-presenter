//
//  UIViews.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import UIKit

extension UIView {
    
    static var separatorH: UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        view.fixHeight(1)
        
        return view
    }
}
