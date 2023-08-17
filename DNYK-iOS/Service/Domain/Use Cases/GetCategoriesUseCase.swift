//
//  GetCategoriesUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol GetCategoriesUseCase {
    func execute() async throws -> [IGroupedCategories]
}

struct DefaultGetCategoriesUseCase: GetCategoriesUseCase {
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [IGroupedCategories] {
        let categories = try await [readyToAssign] + repository.getCategories()
        let categoryGroups: [ICategoryGroup] = try await [inflow] + repository.getCategoryGroups()
        
        var groupedCategories: [String: [ICategory]] = [:]
        
        for category in categories {
            groupedCategories[category.groupId, default: []].append(category)
        }
        
        return categoryGroups.compactMap { group in
            guard let categoriesInGroup = groupedCategories[group.identifier] else {
                return nil
            }
            return IGroupedCategories(group: group, categories: categoriesInGroup)
        }
    }

}
