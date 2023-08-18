//
//  ICategory.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

public protocol ICategory {
    var identifier: String { get }
    var name: String { get }
    var groupId: String { get }
}
