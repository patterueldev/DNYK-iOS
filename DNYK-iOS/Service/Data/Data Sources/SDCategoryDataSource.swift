//
//  SDCategoryDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

// This data source will be using SwiftData as its data source
struct SDCategoryDataSource: CategoryRepository {
    func getCategories() async throws -> [CategoryModel] {
        let seconds: Double = 0.5
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: nanoseconds)
        return [
            SDCategoryModel(identifier: "0", name: "Ready to Assign", groupId: "inflow"),
            
            SDCategoryModel(identifier: "1", name: "Bills", groupId: "bills"),
            SDCategoryModel(identifier: "2", name: "Car", groupId: "bills"),
            SDCategoryModel(identifier: "3", name: "Clothing", groupId: "bills"),
            
            SDCategoryModel(identifier: "4", name: "Food", groupId: "leasure"),
            SDCategoryModel(identifier: "5", name: "Travel", groupId: "leasure"),
            SDCategoryModel(identifier: "6", name: "Hobbies", groupId: "leasure"),
        ]
    }
    
    func getCategoryGroups() async throws -> [CategoryGroupModel] {
        return [
            SDCategoryGroupModel(identifier: "bills", name: "Bills"),
            SDCategoryGroupModel(identifier: "leasure", name: "Leasure"),
            
        ]
    }
}

struct SDCategoryModel: CategoryModel {
    var identifier: String
    var name: String
    var groupId: String
}

struct SDCategoryGroupModel: CategoryGroupModel {
    var identifier: String
    var name: String
    
    static let inflow = SDCategoryGroupModel(identifier: "inflow", name: "Inflow")
}
