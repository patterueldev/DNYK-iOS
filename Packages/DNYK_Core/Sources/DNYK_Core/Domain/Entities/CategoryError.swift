//
//  CategoryError.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/18/23.
//

import Foundation

public enum CategoryError: Error {
    case categoryAlreadyExists
    case categoryWithNameNotExist(name: String)
    
    var localizedDescription: String {
        switch self {
        case .categoryAlreadyExists:
            return "Category already exists"
        case .categoryWithNameNotExist(let name):
            return "Category with name \(name) does not exist"
        }
    }
}
