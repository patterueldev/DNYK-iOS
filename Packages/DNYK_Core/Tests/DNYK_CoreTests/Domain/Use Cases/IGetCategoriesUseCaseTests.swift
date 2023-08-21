//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest

@testable import DNYK_Core

class IGetCategoriesUseCaseTests: XCTestCase {
    var useCase: IGetCategoriesUseCase!
    
    struct MockCategory: ILocalCategory {
        var identifier: String
        var name: String
        var groupId: String
        var remoteIdentifier: String? = nil
        var syncDate: Date? = nil
    }
    
    struct MockCategoryGroup: ILocalCategoryGroup {
        var identifier: String
        var name: String
        var remoteIdentifier: String? = nil
        var syncDate: Date? = nil
    }
    
    class MockGetCategoriesUseCase: IGetCategoriesUseCase {
        func execute() async throws -> [LocalGroupedCategories] {
            return [
                LocalGroupedCategories(
                    group: MockCategoryGroup(
                        identifier: "1234",
                        name: "Group 1"
                    ),
                    categories: [
                        MockCategory(
                            identifier: "1234",
                            name: "Category 1",
                            groupId: "1234"
                        )
                    ]
                )
            ]
        }
    }
    
    override func setUp() {
        super.setUp()
        
        useCase = MockGetCategoriesUseCase()
    }
    
    func testGetCategories() async throws {
        let categories = try await useCase.execute()
        XCTAssertEqual(categories.count, 1)
        XCTAssertEqual(categories[0].group.identifier, "1234")
        XCTAssertEqual(categories[0].group.name, "Group 1")
        XCTAssertEqual(categories[0].categories.count, 1)
        XCTAssertEqual(categories[0].categories[0].identifier, "1234")
        XCTAssertEqual(categories[0].categories[0].name, "Category 1")
        XCTAssertEqual(categories[0].categories[0].groupId, "1234")
    }
}

class DefaultGetCategoriesUseCaseTests: XCTestCase {
    var useCase: IGetCategoriesUseCase!
    var mockCategoryRepository: ILocalCategoryRepository!
    
    override func setUp() {
        super.setUp()
        
        mockCategoryRepository = MockLocalCategoryRepository()
        useCase = DefaultGetCategoriesUseCase(localRepository: mockCategoryRepository)
    }
    
    func testGetCategoriesUseCase() async throws {
        let categories = try await useCase.execute()
        XCTAssertEqual(categories.count, 2)
        let inflowGroup = categories[0]
        let billsGroup = categories[1]
        
        let lInflowGroup = LocalCategoryGroupObject.inflow
        let lReadyToAssignCategory = LocalCategoryObject.readyToAssign
        
        XCTAssertEqual(inflowGroup.group.identifier, lInflowGroup.identifier)
        XCTAssertEqual(inflowGroup.group.name, lInflowGroup.name)
        XCTAssertEqual(inflowGroup.categories.count, 1)
        XCTAssertEqual(inflowGroup.categories[0].identifier, lReadyToAssignCategory.identifier)
        XCTAssertEqual(inflowGroup.categories[0].name, lReadyToAssignCategory.name)
        XCTAssertEqual(inflowGroup.categories[0].groupId, lInflowGroup.identifier)
        
        XCTAssertEqual(billsGroup.group.identifier, "bills")
        XCTAssertEqual(billsGroup.group.name, "Bills")
        XCTAssertEqual(billsGroup.categories.count, 3)
        XCTAssertEqual(billsGroup.categories[0].identifier, "internet")
        XCTAssertEqual(billsGroup.categories[0].name, "Internet")
        XCTAssertEqual(billsGroup.categories[0].groupId, "bills")
        
        XCTAssertEqual(billsGroup.categories[1].identifier, "electricity")
        XCTAssertEqual(billsGroup.categories[1].name, "Electricity")
        
        XCTAssertEqual(billsGroup.categories[2].identifier, "water")
        XCTAssertEqual(billsGroup.categories[2].name, "Water")
    }
}
