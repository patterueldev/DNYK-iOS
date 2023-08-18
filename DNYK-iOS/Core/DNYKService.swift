//
//  DNYKService.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

protocol DNYKService {
    func addTransaction(_ transaction: ITransaction) async throws
    func getCategories() async throws -> [IGroupedCategories]
    func getCategoryGroups() async throws -> [ILocalCategoryGroup]
    func createCategory(name: String, group: String) async throws -> ICategory
}
