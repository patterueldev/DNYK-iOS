//
//  GetCategoriesUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol IGetCategoriesUseCase {
    func execute() async throws -> [IGroupedCategories]
}

struct DefaultGetCategoriesUseCase: IGetCategoriesUseCase {
    private let localRepository: LocalCategoryRepository
    
    init(localRepository: LocalCategoryRepository) {
        self.localRepository = localRepository
    }
    
    func execute() async throws -> [IGroupedCategories] {
        let categories = try await [readyToAssign] + localRepository.getCategories()
        let categoryGroups: [ILocalCategoryGroup] = try await [inflow] + localRepository.getCategoryGroups()
        
        var groupedCategories: [String: [ILocalCategory]] = [:]
        
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
