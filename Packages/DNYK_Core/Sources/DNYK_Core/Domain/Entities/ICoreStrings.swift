//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/19/23.
//

import Foundation

public protocol ICoreStrings {
    func categoryAlreadyExists() -> String
    func categoryWithNameNotExist(name: String) -> String
}

struct DefaultCoreStrings: ICoreStrings {
    func categoryAlreadyExists() -> String {
        return "Category already exists"
    }
    
    func categoryWithNameNotExist(name: String) -> String {
        return "Category with name \(name) does not exist"
    }
}
