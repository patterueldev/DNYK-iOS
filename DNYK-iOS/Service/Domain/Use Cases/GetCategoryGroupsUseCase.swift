//
//  GetCategoryGroupsUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

protocol IGetCategoryGroupsUseCase {
    func execute() async throws -> [ILocalCategoryGroup]
}

struct DefaultGetCategoryGroupsUseCase: IGetCategoryGroupsUseCase {
    private let localRepository: LocalCategoryRepository
    
    init(localRepository: LocalCategoryRepository) {
        self.localRepository = localRepository
    }
    
    func execute() async throws -> [ILocalCategoryGroup] {
        try await localRepository.getCategoryGroups()
    }
}
