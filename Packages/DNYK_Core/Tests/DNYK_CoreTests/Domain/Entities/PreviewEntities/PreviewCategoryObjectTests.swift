import XCTest

@testable import DNYK_Core

class PreviewCategoryObjectTests: XCTestCase {
    
    func testInit() {
        let category = PreviewCategoryObject(identifier: "1", name: "Electricity", groupId: "bills")
        XCTAssertEqual(category.identifier, "1")
        XCTAssertEqual(category.name, "Electricity")
        XCTAssertEqual(category.groupId, "bills")
        XCTAssertEqual(category.remoteIdentifier, nil)
        XCTAssertEqual(category.syncDate, nil)
    }
}

