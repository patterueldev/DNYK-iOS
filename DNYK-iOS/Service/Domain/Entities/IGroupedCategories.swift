//
//  GroupedCategoriesModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

struct IGroupedCategories {
    let group: ICategoryGroup
    let categories: [ICategory]
}

extension IGroupedCategories {
    var identifier: String {
        return group.identifier
    }
    
    var name: String {
        return group.name
    }
}

