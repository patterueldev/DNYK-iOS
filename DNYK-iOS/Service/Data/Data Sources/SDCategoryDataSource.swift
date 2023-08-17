//
//  SDCategoryDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftData

// This data source will be using SwiftData as its data source
struct SDCategoryDataSource: LocalCategoryRepository {
    private let container: ModelContainer
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }
    
    func getCategories() async throws -> [ILocalCategory] {
        let fetchDescriptor = FetchDescriptor<SDCategoryModel>(predicate: .true)
        var categories = try context.fetch(fetchDescriptor)
        
        // if categories are empty, for testing purposes, we will create some
        if categories.isEmpty {
            let sample = SDCategoryModel(name: "Electricity", groupId: "bills")
            context.insert(sample)
            try context.save()
            categories = try context.fetch(fetchDescriptor)
        }
        print("Categories: \(categories.count)")
        return categories
    }
    
    func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
        return [
            SDCategoryGroupModel(identifier: "bills", name: "Bills"),
            SDCategoryGroupModel(identifier: "leasure", name: "Leasure"),
        ]
    }
}

