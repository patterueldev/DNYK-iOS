//
//  GroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/16/23.
//

import Foundation

public protocol ILocalCategoryGroup: ICategoryGroup {
    var remoteIdentifier: String? { get }
    var syncDate: Date? { get }
}

struct LocalCategoryGroupObject: ILocalCategoryGroup {
    public let identifier: String
    public let name: String
    let remoteIdentifier: String? = nil
    let syncDate: Date? = nil
    
    static let inflow = LocalCategoryGroupObject(identifier: "inflow", name: "Inflow")
}
