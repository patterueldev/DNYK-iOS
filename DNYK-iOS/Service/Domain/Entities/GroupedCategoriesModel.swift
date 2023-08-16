//
//  GroupedCategoriesModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

struct GroupedCategoriesModel {
    let group: CategoryGroupModel
    let categories: [CategoryModel]
}

extension GroupedCategoriesModel {
    var identifier: String {
        return group.identifier
    }
    
    var name: String {
        return group.name
    }
}

