//
//  Category.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol ICategory {
    var identifier: String { get }
    var name: String { get }
    var groupId: String { get }
}

struct CategoryObject: ICategory {
    let identifier: String
    let name: String
    let groupId: String
}

let readyToAssign = CategoryObject(identifier: "ready-to-assign", name: "Ready to Assign", groupId: "inflow")
