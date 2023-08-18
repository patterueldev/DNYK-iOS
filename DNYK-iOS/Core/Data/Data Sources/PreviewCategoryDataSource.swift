//
//  PreviewCategoryDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

class PreviewCategoryDataSource: ILocalCategoryRepository {
    private var categories: [ILocalCategory] = [
        PreviewCategoryObject(identifier: "1", name: "Bills", groupId: "bills"),
        PreviewCategoryObject(identifier: "2", name: "Car", groupId: "bills"),
        PreviewCategoryObject(identifier: "3", name: "Clothing", groupId: "bills"),
        PreviewCategoryObject(identifier: "7", name: "Mobile", groupId: "bills"),
        
        PreviewCategoryObject(identifier: "4", name: "Food", groupId: "leasure"),
        PreviewCategoryObject(identifier: "5", name: "Travel", groupId: "leasure"),
        PreviewCategoryObject(identifier: "6", name: "Hobbies", groupId: "leasure"),
    ]
    private var categoryGroups: [ILocalCategoryGroup] = [
        PreviewCategoryGroupObject(identifier: "bills", name: "Bills"),
        PreviewCategoryGroupObject(identifier: "leasure", name: "Leasure"),
    ]
    
    func getCategories() async throws -> [ILocalCategory] {
        let seconds: Double = 0.5
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: nanoseconds)
        return categories
    }
    
    func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
        return categoryGroups
    }
    
    func getCategory(by name: String) async throws -> ILocalCategory {
        return categories.first { $0.name == name }!
    }
    
    func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup {
        let group = categoryGroups.first { $0.name == name }
        if let group = group {
            return group
        } else {
            let newGroup = PreviewCategoryGroupObject(identifier: UUID().uuidString, name: name)
            categoryGroups.append(newGroup)
            return newGroup
        }
    }
    
    func createCategory(name: String, group: ILocalCategoryGroup) async throws -> ILocalCategory {
        let group = try await getOrCreateCategoryGroup(name: group.name)
        let category = PreviewCategoryObject(identifier: UUID().uuidString, name: name, groupId: group.identifier)
        categories.append(category)
        return category
    }
}
