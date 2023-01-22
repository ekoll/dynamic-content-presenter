//
//  FakeFormRepository.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 22.01.2023.
//

import Foundation

class FakeFormRepository: FormRepository {
    
    func getForm() throws -> FormModel {
        let string = """
{
  "header": "Testing",
  "inputs": [
    {
      "title": "Name",
      "hint": "Both your name and family name",
      "type": "textfield"
    },
    {
      "title": "Gender",
      "type": "combobox",
      "detail": {
        "isOptional": true,
        "fields": {
          "m": "Male",
          "f": "Female",
          "n": "Non-Binary"
        }
      }
    },
    {
      "title": "Disclaimer",
      "type": "label",
      "detail": {
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
        "fontName": "Menlo",
        "fontSize": 12
      }
    },
    {
      "title": "Disclaimer",
      "type": "label",
      "detail": {
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
      }
    },
    {
      "title": "Language",
      "type": "combobox",
      "detail": {
        "isOptional": false,
        "fields": {
          "tr": "Turkish",
          "en": "English",
          "fr": "French"
        }
      }
    }
  ]
}
"""
        
        let data = string.data(using: .utf8)!
        
        return try JSONDecoder().decode(FormModel.self, from: data)
    }
}
