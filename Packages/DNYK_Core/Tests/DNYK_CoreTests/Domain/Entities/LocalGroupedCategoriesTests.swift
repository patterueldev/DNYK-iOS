//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest
@testable import DNYK_Core

class LocalGroupedCategoriesTests: XCTestCase {
    var groupedCategories: LocalGroupedCategories!
    
    override func setUp() {
        super.setUp()
        
        groupedCategories = LocalGroupedCategories(
            group: LocalCategoryGroupObject(identifier: "123", name: "Group 1"),
            categories: [
                LocalCategoryObject(
                    identifier: "123",
                    name: "Category 1",
                    groupId: "123"
                ),
            ])
    }
    
    func testIdentifier() {
        XCTAssertEqual(groupedCategories.identifier, "123")
    }
    
    func testName() {
        XCTAssertEqual(groupedCategories.name, "Group 1")
    }
    
    func testCategories() {
        XCTAssertEqual(groupedCategories.categories.count, 1)
        XCTAssertEqual(groupedCategories.categories.first?.identifier, "123")
        XCTAssertEqual(groupedCategories.categories.first?.name, "Category 1")
        XCTAssertEqual(groupedCategories.categories.first?.groupId, "123")
    }
    
    func testGroup() {
        XCTAssertEqual(groupedCategories.group.identifier, "123")
        XCTAssertEqual(groupedCategories.group.name, "Group 1")
    }
    
    func testIfGroupIdAndIdentifierAreEqual() {
        XCTAssertEqual(groupedCategories.group.identifier, groupedCategories.identifier)
    }
    
    func testIfNameAndGroupNameAreEqual() {
        XCTAssertEqual(groupedCategories.name, groupedCategories.group.name)
    }
}
