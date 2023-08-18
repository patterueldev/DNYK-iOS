//
//  SDCategoryGroupModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation
import SwiftData
import DNYK_Core

@Model
class SDCategoryGroupModel: ILocalCategoryGroup {
    @Attribute(.unique) var identifier: String
    var name: String
    
    var remoteIdentifier: String?
    var syncDate: Date?
    
    init(name: String) {
        self.identifier = UUID().uuidString
        self.name = name
    }
}
