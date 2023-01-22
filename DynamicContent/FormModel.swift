//
//  FormModel.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 21.01.2023.
//

import Foundation

struct FormModel: Decodable {
    var header: String
    var inputs: [Input]
}

extension FormModel {
    
    struct Input {
        var title: String
        var hint: String?
        var detail: Detail?
    }
    
    enum Detail: Decodable {
        case textField
        case label(Label)
        case combobox(Combobox)
    }
    
    struct Label: Decodable {
        var text: String
        var fontName: String?
        var fontSize: CGFloat?
    }
    
    struct Combobox: Decodable {
        var fields: [String: String]
        var isOptional: Bool
    }
    
    enum InputType: String, Decodable {
        case textField = "textfield"
        case combobox = "combobox"
        case label = "label"
        case invalid
    }
}

extension FormModel.Input: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title, hint, type, detail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        hint = try container.decodeIfPresent(String.self, forKey: .hint)
        let type = try? container.decode(FormModel.InputType.self, forKey: .type)
        
        do {
            switch type {
            case .textField:
                detail = .textField
            case .label:
                detail = .label(try container.decode(FormModel.Label.self, forKey: .detail))
            case .combobox:
                detail = .combobox(try container.decode(FormModel.Combobox.self, forKey: .detail))
            default:
                detail = nil
            }
        }
        catch {
            detail = nil
        }
    }
}
