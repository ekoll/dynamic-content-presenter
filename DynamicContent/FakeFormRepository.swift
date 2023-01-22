//
//  FakeFormRepository.swift
//  DynamicContent
//
//  Created by Ekrem Duvarbasi on 22.01.2023.
//

import Foundation

class FakeFormRepository: FormRepository {
    
    func getForm() -> FormModel {
        let string = """
"""
        
        let data = string.data(using: .utf8)!
        
        return try! JSONDecoder().decode(FormModel.self, from: data)
    }
}
