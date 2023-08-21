import XCTest

@testable import DNYK_Core

class UtilsTests: XCTestCase {
    func testGenerateUUID() {
        let uuid = Utils.generateUUID(for: .category)
        XCTAssertNotNil(uuid)
    }
    
    func testGetUUID() {
        let uuid = Utils.generateUUID(for: .category)
        let retrievedUUID = Utils.getLatestUUID(for: .category)
        XCTAssertEqual(uuid, retrievedUUID)
    }
    
    func testGetLatestUUID() {
        let uuid = Utils.generateUUID(for: .category)
        let retrievedUUID = Utils.getLatestUUID()
        XCTAssertEqual(uuid, retrievedUUID)
    }
}
