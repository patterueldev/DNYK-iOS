import XCTest
import DNYK_TestCore

@testable import DNYK_Core

class DefaultDNYKServiceTests: XCTestCase {
    var transactionRepository: TransactionRepository!
    var categoryRepository: ILocalCategoryRepository!
    
    var service: DefaultDNYKService!
    
    override func setUp() {
        super.setUp()
        
        transactionRepository = MockTransactionRepository()
        categoryRepository = MockLocalCategoryRepository()
        
        service = DefaultDNYKService(transactionRepository: transactionRepository, localCategoryRepository: categoryRepository)
    }
    
    func testAddTransaction() async throws {
        // TODO: Add test once implementation is done
    }
    
    func testGetCategories() async throws {
        let categoryGroups = try await service.getCategories()
        XCTAssertEqual(categoryGroups.count, 2)
        XCTAssertEqual(categoryGroups[1].group.identifier, "bills")
        XCTAssertEqual(categoryGroups[1].group.name, "Bills")
        XCTAssertEqual(categoryGroups[1].categories.count, 3)
        XCTAssertEqual(categoryGroups[1].categories[0].identifier, "internet")
        XCTAssertEqual(categoryGroups[1].categories[0].name, "Internet")
        XCTAssertEqual(categoryGroups[1].categories[0].groupId, "bills")
    }
    
    func testGetCategoryGroups() async throws {
        let categoryGroups = try await service.getCategoryGroups()
        XCTAssertEqual(categoryGroups.count, 1)
        XCTAssertEqual(categoryGroups[0].identifier, "bills")
        XCTAssertEqual(categoryGroups[0].name, "Bills")
    }
    
    func testCreateCategory() async throws {
        let category = try await service.createCategory(name: "Mobile", group: "Bills")
        XCTAssertEqual(category.identifier, "mobile")
        XCTAssertEqual(category.name, "Mobile")
        XCTAssertEqual(category.groupId, "bills")
    }
}
