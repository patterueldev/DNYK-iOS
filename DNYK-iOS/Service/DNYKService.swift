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
    func getGroups() async throws -> [ILocalCategoryGroup]
//    func createGroup(name: String) async throws -> CategoryGroupModel
//    func createCategory(name: String, group: CategoryGroupModel) async throws -> ICategory
}
