import XCTest

@testable import DNYK_SwiftData

class DNYKSwiftDataTests: XCTestCase {
    func testService() async throws {
//        // Arrange
//        // Act
        let service = DNYKSwiftData.service(inMemory: true)
//        
//        // Assert
        XCTAssertNotNil(service)
    }
}
