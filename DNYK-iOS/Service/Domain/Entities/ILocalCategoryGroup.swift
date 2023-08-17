//
//  GroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

protocol ILocalCategoryGroup {
    var identifier: String { get }
    var name: String { get }
}

struct LocalCategoryGroupObject: ILocalCategoryGroup {
    let identifier: String
    let name: String
}

let inflow = LocalCategoryGroupObject(identifier: "inflow", name: "Inflow")
