//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest
import DNYK_TestCore

@testable import DNYK_Core

class ICreateCategoryUseCaseTests: XCTestCase {
    var useCase: ICreateCategoryUseCase!
    
    struct Category: ILocalCategory {
        var identifier: String
        var name: String
        var groupId: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    struct MockCreateCategoryUseCase: ICreateCategoryUseCase {
        func execute(name: String, group: String) async throws -> ILocalCategory {
            return Category(identifier: "1234", name: name, groupId: group, remoteIdentifier: "1234", syncDate: Date())
        }
    }
    
    override func setUp() {
        super.setUp()
        
        useCase = MockCreateCategoryUseCase()
    }
    
    func testCreateCategory() async throws {
        let category = try await useCase.execute(name: "Category 1", group: "Group 1")
        XCTAssertEqual(category.identifier, "1234")
        XCTAssertEqual(category.name, "Category 1")
        XCTAssertEqual(category.groupId, "Group 1")
        XCTAssertEqual(category.remoteIdentifier, "1234")
        XCTAssertNotNil(category.syncDate)
    }
}

class DefaultCreateCategoryUseCaseTests: XCTestCase {
    var useCase: ICreateCategoryUseCase!
    var mockCategoryRepository: ILocalCategoryRepository!
    
    override func setUp() {
        super.setUp()
        
        mockCategoryRepository = MockLocalCategoryRepository()
        useCase = DefaultCreateCategoryUseCase(localRepository: mockCategoryRepository)
    }
    
    func testCreateCategoryUseCase() async throws {
        let category = try await useCase.execute(name: "Electricity", group: "Bills")
        XCTAssertEqual(category.identifier, "electricity")
        XCTAssertEqual(category.name, "Electricity")
        XCTAssertEqual(category.groupId, "bills")
        XCTAssertEqual(category.remoteIdentifier, "1234")
        XCTAssertNotNil(category.syncDate)
    }
}
