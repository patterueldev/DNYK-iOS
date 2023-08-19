//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest

@testable import DNYK_Core

class CategoryErrorTests: XCTestCase {
    struct MockStrings: ICoreStrings {
        func categoryAlreadyExists() -> String {
            return "The category you are trying to add already exists"
        }
        
        func categoryWithNameNotExist(name: String) -> String {
            return "The category with name '\(name)' does not exist"
        }
    }
    
    override func setUp() {
        super.setUp()
        
        let strings = MockStrings()
        DNYKCore.setCoreStrings(coreStrings: strings)
    }
    
    func testCategoryAlreadyExists() {
        do {
            throw CategoryError.categoryAlreadyExists
            //        } catch {
        } catch {
            XCTAssertEqual(CategoryError.categoryAlreadyExists.localizedDescription, "The category you are trying to add already exists")
        }
    }
    
    func testCategoryWithNameNotExist() {
        do {
            throw CategoryError.categoryWithNameNotExist(name: "Category 1")
        } catch {
            // Assert
            XCTAssertEqual(error.localizedDescription, "The category with name 'Category 1' does not exist")
        }
    }
}

