//
//  DNYKService.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

public protocol IDNYKService {
    func addTransaction(_ transaction: ITransaction) async throws
    func getCategories() async throws -> [LocalGroupedCategories]
    func getCategoryGroups() async throws -> [ILocalCategoryGroup]
    @discardableResult func createCategory(name: String, group: String) async throws -> ICategory
}
