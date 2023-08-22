//
//  SDCategoryDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation
import SwiftData
import DNYK_Core

// This data source will be using SwiftData as its data source
actor SDCategoryDataSource: ModelActor, ILocalCategoryRepository {
    let modelContainer: ModelContainer
    nonisolated public let modelExecutor: ModelExecutor
            
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.modelContainer = container
        self.context = ModelContext(container)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    func getCategories() async throws -> [ILocalCategory] {
        let fetchDescriptor = FetchDescriptor<SDCategoryModel>()
        return try context.fetch(fetchDescriptor)
    }
    
    func getCategory(by name: String) async throws -> ILocalCategory {
        let predicate = #Predicate<SDCategoryModel> {
            $0.name.contains(name)
        }
        let fetchDescriptor = FetchDescriptor<SDCategoryModel>(predicate: predicate)
        let category = try context.fetch(fetchDescriptor).first
        if let category = category {
            return category
        } else {
            throw CategoryError.categoryWithNameNotExist(name: name)
        }
    }
    
    func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
        let fetchDescriptor = FetchDescriptor<SDCategoryGroupModel>()
        return try context.fetch(fetchDescriptor)
    }
    
    func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup {
        let predicate = #Predicate<SDCategoryGroupModel> {
            $0.name.contains(name)
        }
        let fetchDescriptior = FetchDescriptor<SDCategoryGroupModel>(
            predicate: predicate
        )
        let group = try context.fetch(fetchDescriptior).first
        if let group = group {
            return group
        }
        let newGroup = SDCategoryGroupModel.create(name: name)
        context.insert(newGroup)
        try context.save()
        return newGroup
    }
    
    func createCategory(name: String, group: ILocalCategoryGroup) async throws -> ILocalCategory {
        let category = SDCategoryModel.create(name: name, groupId: group.identifier)
        context.insert(category)
        try context.save()
        return category
    }
}

