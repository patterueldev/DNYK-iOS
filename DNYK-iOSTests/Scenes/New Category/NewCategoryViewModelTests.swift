import XCTest
import DNYK_Core
import DNYK_TestCore

@testable import DNYK_iOS

class NewCategoryViewModelTests: XCTestCase {
    var viewModel: NewCategoryViewModel!
    var service: DNYKService!
    
    override func setUpWithError() throws {
        service = MockDNYKService()
        viewModel = NewCategoryViewModel(service: service)
    }
    
    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
    }
    
    func testIsSaveButtonEnabled() throws {
        // Given
        viewModel.name = "Test"
        let group = MockCategoryGroup(identifier: "1", name: "Test")
        viewModel.selectedGroup = .init(group: group)
        viewModel.groupName = "Test"
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertTrue(isEnabled)
    }
    
    func testIsSaveButtonEnabledWhenNameIsEmpty() throws {
        // Given
        viewModel.name = ""
        let group = MockCategoryGroup(identifier: "1", name: "Test")
        viewModel.selectedGroup = .init(group: group)
        viewModel.groupName = "Test"
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertFalse(isEnabled)
    }
    
    func testIsSaveButtonEnabledWhenGroupIsUnselected() throws {
        // Given
        viewModel.name = "Test"
        viewModel.selectedGroup = .unselected()
        viewModel.groupName = "Test"
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertFalse(isEnabled)
    }
    
    func testIsSaveButtonEnabledWhenGroupIsCreateNewAndGroupNameIsEmpty() throws {
        // Given
        viewModel.name = "Test"
        viewModel.selectedGroup = .createNew()
        viewModel.groupName = ""
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertFalse(isEnabled)
    }
    
    func testIsSaveButtonEnabledWhenGroupIsCreateNewAndGroupNameIsNotEmpty() throws {
        // Given
        viewModel.name = "Test"
        viewModel.selectedGroup = .createNew()
        viewModel.groupName = "Test"
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertTrue(isEnabled)
    }
    
    func testIsSaveButtonEnabledWhenLoading() throws {
        // Given
        viewModel.name = "Test"
        let group = MockCategoryGroup(identifier: "1", name: "Test")
        viewModel.selectedGroup = .init(group: group)
        viewModel.groupName = "Test"
        viewModel.isLoading = true
        
        // When
        let isEnabled = viewModel.isSaveButtonEnabled
        
        // Then
        XCTAssertFalse(isEnabled)
    }
}
