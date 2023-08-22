import XCTest
import DNYK_Core
import SwiftData

@testable import DNYK_SwiftData

class SDCategoryModelTests: XCTestCase {
    var modelContainer: ModelContainer!
    var context: ModelContext!
    
    override func setUp() {
        super.setUp()
        
        do {
            let modelContainer = try ModelContainer(for: SDCategoryModel.self)
            let context = ModelContext(modelContainer)
            self.modelContainer = modelContainer
            self.context = context
        
            
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    func testInit() {
        let category = SDCategoryModel.create(name: "Test", groupId: "Test")
        let identifier = Utils.getLatestUUID()
        
        XCTAssertNotNil(category)
        XCTAssertEqual(category.identifier, identifier)
        XCTAssertEqual(category.name, "Test")
        XCTAssertEqual(category.groupId, "Test")
    }
}
