//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest

@testable import DNYK_Core

class ICoreStringsTests: XCTestCase {
    struct TestCoreStrings: ICoreStrings {
        func categoryAlreadyExists() -> String {
            return "Category already exists"
        }
        
        func categoryWithNameNotExist(name: String) -> String {
            return "Category with name \(name) does not exist"
        }
    }
    
    var coreStrings: ICoreStrings!
    
    override func setUp() {
        super.setUp()
        coreStrings = TestCoreStrings()
    }
    
    func testCategoryAlreadyExists() {
        XCTAssertEqual(coreStrings.categoryAlreadyExists(), "Category already exists", "The categoryAlreadyExists method should return the expected value")
    }
    
    func testCategoryWithNameNotExist() {
        XCTAssertEqual(coreStrings.categoryWithNameNotExist(name: "Test"), "Category with name Test does not exist", "The categoryWithNameNotExist method should return the expected value")
    }
    
    // Add more test methods for other properties or behaviors of the ICoreStrings protocol if needed
}

class DefaultCoreStringsTests: XCTestCase {
    var coreStrings: ICoreStrings!
    
    override func setUp() {
        super.setUp()
        coreStrings = DefaultCoreStrings()
    }
    
    func testCategoryAlreadyExists() {
        XCTAssertEqual(coreStrings.categoryAlreadyExists(), "Category already exists", "The categoryAlreadyExists method should return the expected value")
    }
    
    func testCategoryWithNameNotExist() {
        XCTAssertEqual(coreStrings.categoryWithNameNotExist(name: "Test"), "Category with name Test does not exist", "The categoryWithNameNotExist method should return the expected value")
    }
    
    // Add more test methods for other properties or behaviors of the ICoreStrings protocol if needed
}
