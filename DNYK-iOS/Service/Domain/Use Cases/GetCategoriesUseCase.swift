//
//  GetCategoriesUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol GetCategoriesUseCase {
    func execute() async throws -> [GroupedCategoriesModel]
}

struct DefaultGetCategoriesUseCase: GetCategoriesUseCase {
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [GroupedCategoriesModel] {
        let categories = try await [SDCategoryModel.readyToAssign] + repository.getCategories()
        let categoryGroups: [CategoryGroupModel] = try await [SDCategoryGroupModel.inflow] + repository.getCategoryGroups()
        
        var groupedCategories: [String: [CategoryModel]] = [:]
        
        for category in categories {
            groupedCategories[category.groupId, default: []].append(category)
        }
        
        return categoryGroups.compactMap { group in
            guard let categoriesInGroup = groupedCategories[group.identifier] else {
                return nil
            }
            return GroupedCategoriesModel(group: group, categories: categoriesInGroup)
        }
    }

}
