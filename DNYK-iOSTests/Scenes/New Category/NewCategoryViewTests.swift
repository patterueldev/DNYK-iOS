//
//  NewCategoryViewTests.swift
//  DNYK-iOSTests
//
//  Created by John Patrick Teruel on 8/22/23.
//

import XCTest
import DNYK_Core
import DNYK_TestCore

@testable import DNYK_iOS

class NewCategoryViewTests: XCTest {
    // test the NewCategoryView swiftui
    
    var viewModel: NewCategoryViewModel!
    var view: NewCategoryView!
    
    override func setUpWithError() throws {
        view = NewCategoryView(service: MockDNYKService())
        viewModel = view.viewModel
    }
    
    override func tearDownWithError() throws {
        view = nil
        viewModel = nil
    }
    
    func testIsSaveButtonEnabled() throws {
        // Given
        viewModel.name = "Test"
        let group = MockCategoryGroup(identifier: "1", name: "Test")
        viewModel.selectedGroup = .init(group: group)
        viewModel.groupName = "Test"
        
        // When
        
//        XCUIElementQuery.textFields[Constants.AccessibilityIdentifiers.newCategoryViewModelNameTextField]
        
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertTrue(isEnabled)
    }
    
    
}
