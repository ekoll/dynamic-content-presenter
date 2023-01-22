//
//  FormViewModel.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 22.01.2023.
//

import UIKit
import Foundation

protocol FormRepository {
    func getForm() -> FormModel
}

class FormViewModel {
    private let repository: FormRepository
    
    init(repository: FormRepository) {
        self.repository = repository
    }
    
    func generateContent() -> Content {
        let model = repository.getForm()
        
        let views: [UIView] = model.inputs.compactMap { input in
            guard let detal = input.extractViewFromDetal() else {
                return nil
            }
            
            let fieldView = FieldView(input: detal)
            fieldView.title = input.title
            fieldView.hint = input.hint
            
            return fieldView
        }
        
        return .init(header: model.header, views: views)
    }
}

extension FormViewModel {
    
    class Content {
        var header :String
        var views: [UIView]
        
        init(header: String, views: [UIView]) {
            self.header = header
            self.views = views
        }
    }
}

extension FormModel.Input {
    
    func extractViewFromDetal() -> UIView? {
        switch detail {
        case .combobox(let detal):
            let pickerField = PickerField()
            pickerField.isOptional = detal.isOptional
            
            return pickerField
        case .label(let detal):
            let label = UILabel()
            label.text = detal.text
            label.font = UIFont(name: detal.fontName ?? label.font.fontName, size: detal.fontSize ?? label.font.pointSize)
            
            return label
            
        case .textField:
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            
            return textField
            
        case .none:
            return nil
        }
    }
}
