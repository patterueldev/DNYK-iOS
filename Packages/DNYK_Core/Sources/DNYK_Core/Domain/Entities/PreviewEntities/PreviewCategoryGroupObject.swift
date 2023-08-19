//
//  PreviewCategoryGroupObject.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

struct PreviewCategoryGroupObject: ILocalCategoryGroup {
    var identifier: String
    var name: String
    
    var remoteIdentifier: String? = nil
    var syncDate: Date? = nil
}

