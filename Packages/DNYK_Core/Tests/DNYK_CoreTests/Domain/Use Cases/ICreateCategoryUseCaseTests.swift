//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest

@testable import DNYK_Core

class ICreateCategoryUseCaseTests: XCTestCase {
    var useCase: ICreateCategoryUseCase!
    
    struct Category: ILocalCategory {
        var identifier: String
        var name: String
        var groupId: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    struct MockCreateCategoryUseCase: ICreateCategoryUseCase {
        func execute(name: String, group: String) async throws -> ILocalCategory {
            return Category(identifier: "1234", name: name, groupId: group, remoteIdentifier: "1234", syncDate: Date())
        }
    }
    
    override func setUp() {
        super.setUp()
        
        useCase = MockCreateCategoryUseCase()
    }
    
    func testCreateCategory() async throws {
        let category = try await useCase.execute(name: "Category 1", group: "Group 1")
        XCTAssertEqual(category.identifier, "1234")
        XCTAssertEqual(category.name, "Category 1")
        XCTAssertEqual(category.groupId, "Group 1")
        XCTAssertEqual(category.remoteIdentifier, "1234")
        XCTAssertNotNil(category.syncDate)
    }
}

class DefaultCreateCategoryUseCaseTests: XCTestCase {
    var useCase: ICreateCategoryUseCase!
    var mockCategoryRepository: ILocalCategoryRepository!
    
    struct Category: ILocalCategory {
        var identifier: String
        var name: String
        var groupId: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    struct CategoryGroup: ILocalCategoryGroup {
        var identifier: String
        var name: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    class MockLocalCategoryRepository: ILocalCategoryRepository {
        var categories: [ILocalCategory] = [
            Category(identifier: "123", name: "Category 1", groupId: "123", remoteIdentifier: "1234", syncDate: Date())
        ]
        
        var groups: [ILocalCategoryGroup] = [
            CategoryGroup(identifier: "123", name: "Group 1", remoteIdentifier: "1234", syncDate: Date())
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
                let group = CategoryGroup(identifier: name.lowercased(), name: name, remoteIdentifier: "1234", syncDate: Date())
                groups.append(group)
                return group
            }
        }
        
        func createCategory(name: String, group: ILocalCategoryGroup) async throws -> DNYK_Core.ILocalCategory {
            let category = Category(identifier: name.lowercased(), name: name, groupId: group.identifier, remoteIdentifier: "1234", syncDate: Date())
            categories.append(category)
            return category
        }
    }
    
    override func setUp() {
        super.setUp()
        
        mockCategoryRepository = MockLocalCategoryRepository()
        useCase = DefaultCreateCategoryUseCase(localRepository: mockCategoryRepository)
    }
    
    func testCreateCategoryUseCase() async throws {
        let category = try await useCase.execute(name: "Electricity", group: "Bills")
        XCTAssertEqual(category.identifier, "electricity")
        XCTAssertEqual(category.name, "Electricity")
        XCTAssertEqual(category.groupId, "bills")
        XCTAssertEqual(category.remoteIdentifier, "1234")
        XCTAssertNotNil(category.syncDate)
    }
}
