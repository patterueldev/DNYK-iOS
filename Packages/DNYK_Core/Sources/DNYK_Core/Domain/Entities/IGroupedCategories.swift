//
//  GroupedCategoriesModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

public struct IGroupedCategories {
    public let group: ILocalCategoryGroup
    public let categories: [ILocalCategory]
}

public extension IGroupedCategories {
    var identifier: String {
        return group.identifier
    }
    
    var name: String {
        return group.name
    }
}

