import XCTest

@testable import DNYK_Core

class PreviewCategoryGroupObjectTests: XCTestCase {
    func testInit() {
        let group = PreviewCategoryGroupObject(identifier: "1", name: "Bills")
        XCTAssertEqual(group.identifier, "1")
        XCTAssertEqual(group.name, "Bills")
        XCTAssertEqual(group.remoteIdentifier, nil)
        XCTAssertEqual(group.syncDate, nil)
    }
}
