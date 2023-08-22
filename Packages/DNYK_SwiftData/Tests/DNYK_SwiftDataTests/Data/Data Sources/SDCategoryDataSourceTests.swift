import XCTest
import DNYK_Core
import SwiftData

@testable import DNYK_SwiftData

class SDCategoryDataSourceTests: XCTestCase {
    var repository: ILocalCategoryRepository!
    var container: ModelContainer!
    var context: ModelContext!
    
    override func setUp() {
        super.setUp()
        
        do {
            let modelContainer = try ModelContainer(
                for: SDCategoryModel.self, SDCategoryGroupModel.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            let dataSource = SDCategoryDataSource(container: modelContainer)
            self.repository = dataSource
            self.container = modelContainer
            self.context = ModelContext(modelContainer)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    func testGetCategories() async throws {
        // Arrange
        // -- insert group named "Bills"
        let group = SDCategoryGroupModel.create(name: "Bills")
        let latestGroupUUID = Utils.getLatestUUID()
        context.insert(group)
        // -- next, insert category named "Rent" with group id "Bills"
        let category = SDCategoryModel.create(name: "Rent", groupId: group.identifier)
        let latestCategoryUUID = Utils.getLatestUUID()
        context.insert(category)
        try context.save()
        
        // Act
        let categories = try await repository.getCategories()
        
        // Assert
        XCTAssertEqual(categories.count, 1)
        XCTAssertEqual(categories[0].identifier, latestCategoryUUID)
        XCTAssertEqual(categories[0].name, "Rent")
        XCTAssertEqual(categories[0].groupId, latestGroupUUID)
    }
    
    func testGetCategoryByName() async throws {
        // Arrange
        // -- insert group named "Bills"
        let group = SDCategoryGroupModel.create(name: "Bills")
        let latestGroupUUID = Utils.getLatestUUID()
        context.insert(group)
        // -- next, insert category named "Rent" with group id "Bills"
        let category = SDCategoryModel.create(name: "Rent", groupId: group.identifier)
        let latestCategoryUUID = Utils.getLatestUUID()
        context.insert(category)
        try context.save()
        
        // Act
        let categoryByName = try await repository.getCategory(by: "Rent")
        
        // Assert
        XCTAssertEqual(categoryByName.identifier, latestCategoryUUID)
        XCTAssertEqual(categoryByName.name, "Rent")
        XCTAssertEqual(categoryByName.groupId, latestGroupUUID)
    }
    
    func testGetCategoryGroups() async throws {
        // Arrange
        // -- insert group named "Leasure"
        let group = SDCategoryGroupModel.create(name: "Leasure")
        let latestGroupUUID = Utils.getLatestUUID()
        context.insert(group)
        try context.save()
        
        // Act
        let groups = try await repository.getCategoryGroups()
        
        // Assert
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups[0].identifier, latestGroupUUID)
        XCTAssertEqual(groups[0].name, "Leasure")
    }
    
    func testGetOrCreateCategoryGroupWithName() async throws {
        // Arrange
        // Act
        let groupByName = try await repository.getOrCreateCategoryGroup(name: "Leasure")
        let latestGroupUUID = Utils.getLatestUUID()
        
        // Assert
        XCTAssertEqual(groupByName.identifier, latestGroupUUID)
        XCTAssertEqual(groupByName.name, "Leasure")
    }
    
    func testCreateCategory() async throws {
        // Arrange
        // -- insert group named "Bills"
        let group = SDCategoryGroupModel.create(name: "Bills")
        let latestGroupUUID = Utils.getLatestUUID()
        context.insert(group)
        try context.save()
        
        // Act
        let category = try await repository.createCategory(name: "Rent", group: group)
        let latestCategoryUUID = Utils.getLatestUUID()
        
        // Assert
        XCTAssertEqual(category.identifier, latestCategoryUUID)
        XCTAssertEqual(category.name, "Rent")
        XCTAssertEqual(category.groupId, latestGroupUUID)
    }
}
