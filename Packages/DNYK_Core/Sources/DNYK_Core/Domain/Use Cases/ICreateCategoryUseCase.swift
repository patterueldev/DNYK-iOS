//
//  ICreateCategoryUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/18/23.
//

import Foundation

protocol ICreateCategoryUseCase {
    func execute(name: String, group: String) async throws -> ILocalCategory
}

struct DefaultCreateCategoryUseCase: ICreateCategoryUseCase {
    private let localRepository: ILocalCategoryRepository
    
    init(localRepository: ILocalCategoryRepository) {
        self.localRepository = localRepository
    }
    
    func execute(name: String, group: String) async throws -> ILocalCategory {
        // validate if category already exists
        do {
            let category = try await localRepository.getCategory(by: name)
            if category.name == name {
                throw CategoryError.categoryAlreadyExists
            }
        } catch {
            // category does not exist; proceed
            print("Category does not exist. Will proceed to create category")
        }
        
        let group = try await localRepository.getOrCreateCategoryGroup(name: group)
        return try await localRepository.createCategory(name: name, group: group)
    }
}

