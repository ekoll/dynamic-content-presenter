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
    
    struct PickerFieldData: PickerData {
        var pickerID: String
        var pickerText: String
    }
}

extension FormModel.Input {
    
    func extractViewFromDetal() -> UIView? {
        switch detail {
        case .combobox(let detal):
            let pickerField = PickerField()
            pickerField.borderStyle = .roundedRect
            pickerField.isOptional = detal.isOptional
            pickerField.setDataSource(detal.fields.map {
                FormViewModel.PickerFieldData(pickerID: $0.key, pickerText: $0.value)
            })
            
            return pickerField
        case .label(let detal):
            let label = UILabel()
            label.text = detal.text
            label.numberOfLines = 0
            
            if let fontName = detal.fontName {
                label.font = UIFont(name: fontName, size: UIFont.systemFontSize)
            }
            if let fontSize = detal.fontSize {
                label.font = label.font.withSize(fontSize)
            }
            
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
