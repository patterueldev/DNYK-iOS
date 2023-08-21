import XCTest
import DNYK_Core
import SwiftData

@testable import DNYK_SwiftData

class SDCategoryGroupModelTests: XCTestCase {
    var modelContainer: ModelContainer!
    
    override func setUp() {
        super.setUp()
        
        do {
            let modelContainer = try ModelContainer(for: [SDCategoryGroupModel.self])
            self.modelContainer = modelContainer
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    func testInit() {
        let group = SDCategoryGroupModel(name: "Test")
        let identifier = Utils.getLatestUUID()
        
        XCTAssertNotNil(group)
        XCTAssertEqual(group.identifier, identifier)
        XCTAssertEqual(group.name, "Test")
    }
}
