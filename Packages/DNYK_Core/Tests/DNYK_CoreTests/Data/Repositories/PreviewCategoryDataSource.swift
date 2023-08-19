//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest
@testable import DNYK_Core

class PreviewCategoryDataSourceTests: XCTestCase {
    
    var repository: ILocalCategoryRepository!
    
    override func setUp() {
        super.setUp()
        repository = PreviewCategoryDataSource()
    }
    
    func testGetCategories() async throws {
        let categories = try await repository.getCategories()
        XCTAssertEqual(categories.count, 7)
    }
    
    func testGetCategory() async throws {
        let category = try await repository.getCategory(by: "Electricity")
        XCTAssertEqual(category.identifier, "1")
        XCTAssertEqual(category.name, "Electricity")
        XCTAssertEqual(category.groupId, "bills")
    }
    
    func testGetCategoryGroups() async throws {
        let groups = try await repository.getCategoryGroups()
        XCTAssertEqual(groups.count, 2)
        XCTAssertEqual(groups.first?.identifier, "bills")
        XCTAssertEqual(groups.first?.name, "Bills")
    }
    
    func testGetOrCreateCategoryGroup() async throws {
        let group = try await repository.getOrCreateCategoryGroup(name: "Bills")
        XCTAssertEqual(group.identifier, "bills")
        XCTAssertEqual(group.name, "Bills")
    }
    
    func testCreateCategory() async throws {
        let group = try await repository.getOrCreateCategoryGroup(name: "Group 1")
        let category = try await repository.createCategory(name: "Category 1", group: group)
        
        XCTAssertEqual(category.name, "Category 1")
        XCTAssertEqual(category.groupId, group.identifier)
        
        let categories = try await repository.getCategories()
        XCTAssertEqual(categories.count, 8)
    }
}

