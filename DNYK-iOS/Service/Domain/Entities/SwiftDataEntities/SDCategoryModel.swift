//
//  SDCategoryModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation
import SwiftData

@Model
class SDCategoryModel: CategoryModel {
    @Attribute(.unique) var identifier: String
    var name: String
    var groupId: String
    
    var remoteId: String?
    
    init(name: String, groupId: String) {
        self.identifier = UUID().uuidString
        self.name = name
        self.groupId = groupId
        self.remoteId = nil
    }
}
