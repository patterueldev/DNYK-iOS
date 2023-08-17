//
//  CategoryRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol LocalCategoryRepository {
    func getCategories() async throws -> [ILocalCategory]
    func getCategoryGroups() async throws -> [ILocalCategoryGroup]
}
