import XCTest

@testable import DNYK_Core

class DNYKCoreTests: XCTestCase {
    // most of these are static, so it's ok to use the same instance
    
    func testSetCoreStrings() {
        let coreStrings = DefaultCoreStrings()
        DNYKCore.setCoreStrings(coreStrings)
        XCTAssertEqual(DNYKCore.coreStrings.categoryAlreadyExists(), coreStrings.categoryAlreadyExists())
        XCTAssertEqual(DNYKCore.coreStrings.categoryWithNameNotExist(name: "Category 1"), coreStrings.categoryWithNameNotExist(name: "Category 1"))
    }
}
