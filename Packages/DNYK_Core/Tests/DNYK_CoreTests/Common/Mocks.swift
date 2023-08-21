//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/21/23.
//

import Foundation

@testable import DNYK_Core

struct MockCategory: ILocalCategory {
    var identifier: String
    var name: String
    var groupId: String
    var remoteIdentifier: String? = nil
    var syncDate: Date? = nil
}

struct MockCategoryGroup: ILocalCategoryGroup {
    var identifier: String
    var name: String
    var remoteIdentifier: String? = nil
    var syncDate: Date? = nil
}

class MockLocalCategoryRepository: ILocalCategoryRepository {
    var categories: [ILocalCategory] = [
        MockCategory(identifier: "internet", name: "Internet", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
        MockCategory(identifier: "electricity", name: "Electricity", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
        MockCategory(identifier: "water", name: "Water", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
    ]
    
    var groups: [ILocalCategoryGroup] = [
        MockCategoryGroup(identifier: "bills", name: "Bills", remoteIdentifier: "1234", syncDate: Date())
    ]
    
    func getCategories() async throws -> [ILocalCategory] {
        return categories
    }
    
    func getCategory(by name: String) async throws -> ILocalCategory {
        let category = categories.first { $0.name == name }
        guard let category = category else {
            throw CategoryError.categoryWithNameNotExist(name: name)
        }
        return category
    }
    
    func getCategoryGroups() async throws -> [DNYK_Core.ILocalCategoryGroup] {
        return groups
    }
    
    func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup {
        if let group = groups.first (where: { $0.name == name }) {
            return group
        } else {
            let group = MockCategoryGroup(identifier: name.lowercased(), name: name, remoteIdentifier: "1234", syncDate: Date())
            groups.append(group)
            return group
        }
    }
    
    func createCategory(name: String, group: ILocalCategoryGroup) async throws -> DNYK_Core.ILocalCategory {
        let category = MockCategory(identifier: name.lowercased(), name: name, groupId: group.identifier, remoteIdentifier: "1234", syncDate: Date())
        categories.append(category)
        return category
    }
}

struct MockTransaction: ITransaction {
    var category: ILocalCategory
}



class MockTransactionRepository: TransactionRepository {
    func addTransaction(_ transaction: ITransaction) async throws {
        
    }
}
