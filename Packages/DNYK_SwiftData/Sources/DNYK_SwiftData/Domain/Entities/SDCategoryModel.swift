//
//  SDCategoryModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation
import SwiftData
import DNYK_Core

@Model
class SDCategoryModel: ILocalCategory {
    @Attribute(.unique) var identifier: String
    var name: String
    var groupId: String
    
    var remoteIdentifier: String?
    var syncDate: Date?
    
    private init(name: String, groupId: String) {
        self.identifier = Utils.generateUUID(for: .category)
        self.name = name
        self.groupId = groupId
    }
    
    static func create(name: String, groupId: String) -> SDCategoryModel {
        return SDCategoryModel(name: name, groupId: groupId)
    }
}
