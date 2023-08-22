import XCTest
import DNYK_TestCore

@testable import DNYK_Core

class DNYKServiceTests: XCTestCase {
    var service: DNYKService!
    
    override func setUp() {
        super.setUp()
        
        service = MockDNYKService()
    }
    
    func testGetCategories() async throws {
        let categories = try await service.getCategories()
        
        XCTAssertEqual(categories.count, 1)
        XCTAssertEqual(categories.first?.group.identifier, "bills")
        XCTAssertEqual(categories.first?.group.name, "Bills")
        XCTAssertEqual(categories.first?.categories.count, 2)
        XCTAssertEqual(categories.first?.categories.first?.identifier, "electricity")
        XCTAssertEqual(categories.first?.categories.first?.name, "Electricity")
    }
    
    func testGetCategoryGroups() async throws {
        let groups = try await service.getCategoryGroups()
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.identifier, "bills")
        XCTAssertEqual(groups.first?.name, "Bills")
    }

    func testCreateCategory() async throws {
        let category = try await service.createCategory(name: "Water", group: "bills")
        
        XCTAssertEqual(category.identifier, "water")
        XCTAssertEqual(category.name, "Water")
        XCTAssertEqual(category.groupId, "bills")
    }
}
