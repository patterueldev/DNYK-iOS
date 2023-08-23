import XCTest
import DNYK_Core
import DNYK_TestCore

@testable import DNYK_iOS

class NewCategoryViewModelTests: XCTestCase {
    var viewModel: NewCategoryViewModel!
    var service: IDNYKService!
    
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
    
    func testFetchCategoryGroups() throws {
        // Given
        let expectation = expectation(description: "fetchCategoryGroups")
        
        // When
        viewModel.fetchCategoryGroups()
        
        // Then
        // assert after `isLoading` is set to false
        // use timer to wait for the async task to finish
        // retry for up to 10 times, every 1 second
        var retryCount = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !self.viewModel.isLoading {
                XCTAssertEqual(self.viewModel.categoryGroups.count, 3)
                expectation.fulfill()
                timer.invalidate()
            } else if retryCount >= 10 {
                expectation.fulfill()
                timer.invalidate()
            }
            retryCount += 1
        }
        
        waitForExpectations(timeout: 2)
    }
    
    func testSaveWithCompletion() {
        // Given
        let expectation = expectation(description: "saveWithCompletion")
        viewModel.name = "Test"
        let group = MockCategoryGroup(identifier: "1", name: "Test")
        viewModel.selectedGroup = .init(group: group)
        viewModel.groupName = "Test"
        
        // When
        viewModel.save { didSucceed in
            XCTAssertTrue(didSucceed)
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 2)
    }
    
}
