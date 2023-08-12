//
//  GetCategoriesUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol GetCategoriesUseCase {
    func execute() async throws -> [CategoryModel]
}

struct DefaultGetCategoriesUseCase: GetCategoriesUseCase {
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [CategoryModel] {
        try await repository.getCategories()
    }
}
