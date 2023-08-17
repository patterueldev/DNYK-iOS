//
//  GroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

protocol ILocalCategoryGroup: ICategoryGroup {
}

struct LocalCategoryGroupObject: ILocalCategoryGroup {
    let identifier: String
    let name: String
}

let inflow = LocalCategoryGroupObject(identifier: "inflow", name: "Inflow")
