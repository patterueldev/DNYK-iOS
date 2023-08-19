//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest
@testable import DNYK_Core

class ILocalCategoryTests: XCTestCase {
    
    var category: ILocalCategory!
    
    // Create an instance of a class that conforms to the ICategory protocol
    class Category: ILocalCategory {
        let identifier: String = "123"
        let name: String = "Category 1"
        let groupId: String = "Group 1"
        
        let remoteIdentifier: String? = "1234"
        let syncDate: Date? = Date()
    }
    
    override func setUp() {
        super.setUp()
        // Create an instance of the category class before each test method
        category = Category()
    }
    
    // Test the identifier property
    func testIdentifier() {
        // Test the identifier property
        XCTAssertEqual(category.identifier, "123", "The identifier property should return the expected value")
    }
    
    // Test the name property
    func testName() {
        // Test the name property
        XCTAssertEqual(category.name, "Category 1", "The name property should return the expected value")
    }
    
    // Test the groupId property
    func testGroupId() {
        // Test the groupId property
        XCTAssertEqual(category.groupId, "Group 1", "The groupId property should return the expected value")
    }
    
    // Test the remoteIdentifier property
    func testRemoteIdentifier() {
        // Test the remoteIdentifier property
        XCTAssertEqual(category.remoteIdentifier, "1234", "The remoteIdentifier property should return the expected value")
    }
    
    // Test the syncDate property
    func testSyncDate() {
        // Test the syncDate property
        XCTAssertNotNil(category.syncDate, "The syncDate property should not be nil")
    }
    
    // Add more test methods for other properties or behaviors of the ICategory protocol if needed
    
}
