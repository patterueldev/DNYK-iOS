//
//  NewCategoryViewTests.swift
//  DNYK-iOSTests
//
//  Created by John Patrick Teruel on 8/22/23.
//

import XCTest
import DNYK_Core
import DNYK_TestCore
import ViewInspector

@testable import DNYK_iOS

class NewCategoryViewTests: XCTestCase {
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
    
    func testCategoryNameViewModelTwoWay() throws {
        // first, test changing the view model property if the text field is changed
        // Given
        viewModel.name = "Test"
        
        // When
//        find using accessibility identifier
        let identifier = Constants.AccessibilityIdentifiers.newCategoryViewNameTextField
        let nameField = try view.inspect().find(viewWithAccessibilityIdentifier: identifier).textField()
        
        // Then
        try XCTAssertEqual(nameField.input(), "Test")
        
        // then test changing the text field if the view model property is changed
        // Given
        try nameField.setInput("Test 2")
        
        // When
        let newName = viewModel.name
        
        // Then
        XCTAssertEqual(newName, "Test 2")
    }
    
    func testCategoryGroupField() throws {
        // Given
        let group = MockCategoryGroup(identifier: "1", name: "Bills")
        viewModel.selectedGroup = .init(group: group)
        
        // When
        let groupField = try view.inspect().find(viewWithAccessibilityIdentifier: Constants.AccessibilityIdentifiers.newCategoryViewGroupField).picker()
        
        
        // Then
        let selected = try groupField.selectedValue(NewCategoryViewModel.CategoryGroupWrapper.self)
        XCTAssertEqual(selected.name, "Bills")
    }
    
    func testCategoryNewGroupFieldTwoWay() throws {
        // Given
        viewModel.selectedGroup = .createNew()
        viewModel.groupName = "Leasure"
        
        // When
        let groupField = try view.inspect().find(viewWithAccessibilityIdentifier: Constants.AccessibilityIdentifiers.nameCategoryViewNewGroupTextField).textField()
        
        // Then
        try XCTAssertEqual(groupField.input(), "Leasure")
        
        // Given
        try groupField.setInput("Emergency")
        
        // When
        let newGroupName = viewModel.groupName
        
        // Then
        XCTAssertEqual(newGroupName, "Emergency")
    }
}
