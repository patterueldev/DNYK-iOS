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
        // TODO: Implement Fetching of Categories
//        throw NSError(domain: "Not Implemented", code: 0, userInfo: nil)
        let seconds: Double = 0.5
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: nanoseconds)
        return [SDCategoryModel(id: "0", name: "Ready to Assign")]
    }
}

struct SDCategoryModel: CategoryModel {
    var id: String
    var name: String
}

