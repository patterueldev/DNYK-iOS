//
//  Category.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

public protocol ILocalCategory: ICategory {
    var remoteIdentifier: String? { get }
    var syncDate: Date? { get }
}

public extension ILocalCategory {
    var isSynced: Bool {
        syncDate != nil
    }
}

struct LocalCategoryObject: ILocalCategory {
    let identifier: String
    let name: String
    let groupId: String
    let remoteIdentifier: String? = nil
    let syncDate: Date? = nil
    
    static let readyToAssign = LocalCategoryObject(identifier: "ready-to-assign", name: "Ready to Assign", groupId: "inflow")
}
