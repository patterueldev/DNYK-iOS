//
//  PreviewCategoryDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

struct PreviewCategoryDataSource: CategoryRepository {
    func getCategories() async throws -> [CategoryModel] {
        let seconds: Double = 0.5
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: nanoseconds)
        return [
            PreviewCategoryObject(identifier: "1", name: "Bills", groupId: "bills"),
            PreviewCategoryObject(identifier: "2", name: "Car", groupId: "bills"),
            PreviewCategoryObject(identifier: "3", name: "Clothing", groupId: "bills"),
            PreviewCategoryObject(identifier: "7", name: "Mobile", groupId: "bills"),
            
            PreviewCategoryObject(identifier: "4", name: "Food", groupId: "leasure"),
            PreviewCategoryObject(identifier: "5", name: "Travel", groupId: "leasure"),
            PreviewCategoryObject(identifier: "6", name: "Hobbies", groupId: "leasure"),
        ]
    }
    
    func getCategoryGroups() async throws -> [CategoryGroupModel] {
        return [
            PreviewCategoryGroupObject(identifier: "bills", name: "Bills"),
            PreviewCategoryGroupObject(identifier: "leasure", name: "Leasure"),
        ]
    }
}
