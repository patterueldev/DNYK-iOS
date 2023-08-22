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

public struct MockCategoryGroup: ILocalCategoryGroup {
    public var identifier: String
    public var name: String
    public var remoteIdentifier: String? = nil
    public var syncDate: Date? = nil
    
    public init(identifier: String, name: String, remoteIdentifier: String? = nil, syncDate: Date? = nil) {
        self.identifier = identifier
        self.name = name
        self.remoteIdentifier = remoteIdentifier
        self.syncDate = syncDate
    }
}

public class MockLocalCategoryRepository: ILocalCategoryRepository {
    var categories: [ILocalCategory] = [
        MockCategory(identifier: "internet", name: "Internet", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
        MockCategory(identifier: "electricity", name: "Electricity", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
        MockCategory(identifier: "water", name: "Water", groupId: "bills", remoteIdentifier: "1234", syncDate: Date()),
    ]
    
    var groups: [ILocalCategoryGroup] = [
        MockCategoryGroup(identifier: "bills", name: "Bills", remoteIdentifier: "1234", syncDate: Date())
    ]
    
    public init() {}
    
    public func getCategories() async throws -> [ILocalCategory] {
        return categories
    }
    
    public func getCategory(by name: String) async throws -> ILocalCategory {
        let category = categories.first { $0.name == name }
        guard let category = category else {
            throw CategoryError.categoryWithNameNotExist(name: name)
        }
        return category
    }
    
    public func getCategoryGroups() async throws -> [DNYK_Core.ILocalCategoryGroup] {
        return groups
    }
    
    public func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup {
        if let group = groups.first (where: { $0.name == name }) {
            return group
        } else {
            let group = MockCategoryGroup(identifier: name.lowercased(), name: name, remoteIdentifier: "1234", syncDate: Date())
            groups.append(group)
            return group
        }
    }
    
    public func createCategory(name: String, group: ILocalCategoryGroup) async throws -> DNYK_Core.ILocalCategory {
        let category = MockCategory(identifier: name.lowercased(), name: name, groupId: group.identifier, remoteIdentifier: "1234", syncDate: Date())
        categories.append(category)
        return category
    }
}

struct MockTransaction: ITransaction {
    var category: ILocalCategory
}



public class MockTransactionRepository: TransactionRepository {
    public init() {}
    
    public func addTransaction(_ transaction: ITransaction) async throws {
        
    }
}

public class MockDNYKService: DNYKService {
    let billsGroup = MockCategoryGroup(identifier: "bills", name: "Bills", remoteIdentifier: "1234", syncDate: Date())
    
    public init() {}
    
    public func addTransaction(_ transaction: DNYK_Core.ITransaction) async throws {
        // TODO: Implement
    }
    
    public func getCategories() async throws -> [DNYK_Core.LocalGroupedCategories] {
        let electricCategory = MockCategory(identifier: "electricity", name: "Electricity", groupId: "bills", remoteIdentifier: "1234", syncDate: Date())
        let internetCategory = MockCategory(identifier: "internet", name: "Internet", groupId: "bills", remoteIdentifier: "1234", syncDate: Date())
        return [
            LocalGroupedCategories(group: billsGroup, categories: [electricCategory, internetCategory])
        ]
    }
    
    public func getCategoryGroups() async throws -> [DNYK_Core.ILocalCategoryGroup] {
        return [
            billsGroup
        ]
    }
    
    public func createCategory(name: String, group: String) async throws -> DNYK_Core.ICategory {
        return MockCategory(identifier: name.lowercased(), name: name, groupId: group, remoteIdentifier: "1234", syncDate: Date())
    }
}
