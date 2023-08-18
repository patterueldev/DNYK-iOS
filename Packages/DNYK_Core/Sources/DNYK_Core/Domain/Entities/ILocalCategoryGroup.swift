//
//  GroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

public protocol ILocalCategoryGroup: ICategoryGroup {
}

public struct LocalCategoryGroupObject: ILocalCategoryGroup {
    public let identifier: String
    public let name: String
}

let inflow = LocalCategoryGroupObject(identifier: "inflow", name: "Inflow")
