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
    
    var service: DNYKService!
    var viewModel: NewCategoryViewModel!
    var view: NewCategoryView!
    
    override func setUpWithError() throws {
        let transactionRepository = MockTransactionRepository()
        let localCategoryRepository = MockLocalCategoryRepository()
        
        service = DefaultDNYKService(transactionRepository: transactionRepository, localCategoryRepository: localCategoryRepository)
        view = NewCategoryView(service: service)
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
        let groupField = try view.inspect().find(viewWithAccessibilityIdentifier: Constants.AccessibilityIdentifiers.newCategoryViewNewGroupTextField).textField()
        
        // Then
        try XCTAssertEqual(groupField.input(), "Leasure")
        
        // Given
        try groupField.setInput("Emergency")
        
        // When
        let newGroupName = viewModel.groupName
        
        // Then
        XCTAssertEqual(newGroupName, "Emergency")
    }
    
    func testSaveCategory() async throws {
        // Given
        let billsGroup = MockCategoryGroup(identifier: "bills", name: "Bills")
        viewModel.name = "Mobile"
        viewModel.selectedGroup = .init(group: billsGroup)
        var groupedCategories = try await service.getCategories()
        
        // When
        let saveButton = try view.inspect().find(viewWithAccessibilityIdentifier: Constants.AccessibilityIdentifiers.newCategoryViewSaveButton).button()
        try saveButton.tap() // wait and check if dismissed
        // delay for about 0.5 seconds and fulfill the expectation
        let expectation = self.expectation(description: "dismissed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        
        // Then
        
        // assert previous grouped category
        XCTAssertEqual(groupedCategories.count, 2)
        XCTAssertEqual(groupedCategories.last?.name, "Bills")
        XCTAssertEqual(groupedCategories.last?.group.identifier, billsGroup.identifier)
        XCTAssertEqual(groupedCategories.last?.group.name, billsGroup.name)
        XCTAssertEqual(groupedCategories.last?.categories.count, 3)
        XCTAssertEqual(groupedCategories.last?.categories.last?.name, "Water")
        
        groupedCategories = try await service.getCategories()
        
        // assert updated grouped category
        XCTAssertEqual(groupedCategories.count, 2)
        XCTAssertEqual(groupedCategories.last?.name, "Bills")
        XCTAssertEqual(groupedCategories.last?.group.identifier, billsGroup.identifier)
        XCTAssertEqual(groupedCategories.last?.group.name, billsGroup.name)
        XCTAssertEqual(groupedCategories.last?.categories.count, 4)
        XCTAssertEqual(groupedCategories.last?.categories.last?.name, "Mobile")
    }
}
