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
    
    private var strings : ICoreStrings {
        return DNYKCore.coreStrings
    }
    
    var localizedDescription: String {
        switch self {
        case .categoryAlreadyExists:
            return strings.categoryAlreadyExists()
        case .categoryWithNameNotExist(let name):
            return strings.categoryWithNameNotExist(name: name)
        }
    }
}
