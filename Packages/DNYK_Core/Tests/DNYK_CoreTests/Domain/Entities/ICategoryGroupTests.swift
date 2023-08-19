//
//  ICategoryGroupTest.swift
//  DNYK-iOSTests
//
//  Created by John Patrick Teruel on 8/17/23.
//

import XCTest

@testable import DNYK_Core

class ICategoryGroupTests: XCTestCase {
    
    var categoryGroup: CategoryGroup!
    
    // Create an instance of a class that conforms to the ICategoryGroup protocol
    class CategoryGroup: ILocalCategoryGroup {
        let identifier: String = "123"
        let name: String = "Group 1"
        
        let remoteIdentifier: String? = "1234"
        let syncDate: Date? = Date()
    }
    
    override func setUp() {
        super.setUp()
        // Create an instance of the category group class before each test method
        categoryGroup = CategoryGroup()
    }
    
    // Test the identifier property
    func testIdentifier() {
        // Test the identifier property
        XCTAssertEqual(categoryGroup.identifier, "123", "The identifier property should return the expected value")
    }
    
    // Test the name property
    func testName() {
        // Test the name property
        XCTAssertEqual(categoryGroup.name, "Group 1", "The name property should return the expected value")
    }
    
    // Test the remoteIdentifier property
    func testRemoteIdentifier() {
        // Test the remoteIdentifier property
        XCTAssertEqual(categoryGroup.remoteIdentifier, "1234", "The remoteIdentifier property should return the expected value")
    }
    
    // Test the syncDate property
    func testSyncDate() {
        // Test the syncDate property
        XCTAssertNotNil(categoryGroup.syncDate, "The syncDate property should return the expected value")
    }
    
    // Add more test methods for other properties or behaviors of the ICategoryGroup protocol if needed
    
}