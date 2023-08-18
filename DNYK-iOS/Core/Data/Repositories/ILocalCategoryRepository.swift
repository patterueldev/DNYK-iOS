//
//  CategoryRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol ILocalCategoryRepository {
    func getCategories() async throws -> [ILocalCategory]
    func getCategory(by name: String) async throws -> ILocalCategory
    func getCategoryGroups() async throws -> [ILocalCategoryGroup]
    func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup
    func createCategory(name: String, group: ILocalCategoryGroup) async throws -> ILocalCategory
}
