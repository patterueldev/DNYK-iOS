//
//  GetCategoriesUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol IGetCategoriesUseCase {
    func execute() async throws -> [LocalGroupedCategories]
}

struct DefaultGetCategoriesUseCase: IGetCategoriesUseCase {
    private let localRepository: ILocalCategoryRepository
    
    init(localRepository: ILocalCategoryRepository) {
        self.localRepository = localRepository
    }
    
    func execute() async throws -> [LocalGroupedCategories] {
        let categories = try await [LocalCategoryObject.readyToAssign] + localRepository.getCategories()
        let categoryGroups: [ILocalCategoryGroup] = try await [LocalCategoryGroupObject.inflow] + localRepository.getCategoryGroups()
        
        var groupedCategories: [String: [ILocalCategory]] = [:]
        
        for category in categories {
            groupedCategories[category.groupId, default: []].append(category)
        }
        
        return categoryGroups.compactMap { group in
            guard let categoriesInGroup = groupedCategories[group.identifier] else {
                return nil
            }
            return LocalGroupedCategories(group: group, categories: categoriesInGroup)
        }
    }

}
