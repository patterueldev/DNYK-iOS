//
//  GroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

protocol ICategoryGroup {
    var identifier: String { get }
    var name: String { get }
}

struct CategoryGroupObject: ICategoryGroup {
    let identifier: String
    let name: String
}

let inflow = CategoryGroupObject(identifier: "inflow", name: "Inflow")
