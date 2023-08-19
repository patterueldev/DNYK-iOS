//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest
@testable import DNYK_Core

class ILocalCategoryRepositoryTests: XCTestCase {
    
    var repository: ILocalCategoryRepository!
    
    override func setUp() {
        super.setUp()
        repository = LocalCategoryDataSource()
    }
    
    class LocalCategoryDataSource: ILocalCategoryRepository {
        func getCategories() async throws -> [ILocalCategory] {
            return []
        }
        
        func getCategory(by name: String) async throws -> ILocalCategory {
            return LocalCategoryObject(identifier: "123", name: "Category 1", groupId: "123")
        }
        
        func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
            return [
                LocalCategoryGroupObject(identifier: "123", name: "Group 1")
            ]
        }
        
        func getOrCreateCategoryGroup(name: String) async throws -> ILocalCategoryGroup {
            return LocalCategoryGroupObject(identifier: "123", name: "Group 1")
        }
        
        func createCategory(name: String, group: ILocalCategoryGroup) async throws -> ILocalCategory {
            return LocalCategoryObject(identifier: "123", name: name, groupId: group.identifier)
        }
    }
    
    func testGetCategories() async throws {
        let categories = try await repository.getCategories()
        XCTAssertEqual(categories.count, 0)
    }
    
    func testGetCategory() async throws {
        let category = try await repository.getCategory(by: "Category 1")
        XCTAssertEqual(category.identifier, "123")
        XCTAssertEqual(category.name, "Category 1")
        XCTAssertEqual(category.groupId, "123")
    }
    
    func testGetCategoryGroups() async throws {
        let groups = try await repository.getCategoryGroups()
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.identifier, "123")
        XCTAssertEqual(groups.first?.name, "Group 1")
    }
    
    func testGetOrCreateCategoryGroup() async throws {
        let group = try await repository.getOrCreateCategoryGroup(name: "Group 1")
        XCTAssertEqual(group.identifier, "123")
        XCTAssertEqual(group.name, "Group 1")
    }
    
    func testCreateCategory() async throws {
        let group = LocalCategoryGroupObject(identifier: "123", name: "Group 1")
        let category = try await repository.createCategory(name: "Category 1", group: group)
        XCTAssertEqual(category.identifier, "123")
        XCTAssertEqual(category.name, "Category 1")
        XCTAssertEqual(category.groupId, "123")
    }
}

