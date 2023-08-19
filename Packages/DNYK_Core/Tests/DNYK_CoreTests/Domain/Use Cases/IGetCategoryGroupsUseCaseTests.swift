//
//  File.swift
//
//
//  Created by John Patrick Teruel on 8/19/23.
//

import XCTest

@testable import DNYK_Core

class IGetCategoryGroupsUseCaseTests: XCTestCase {
    var useCase: IGetCategoryGroupsUseCase!
    
    struct MockCategoryGroup: ILocalCategoryGroup {
        var identifier: String
        var name: String
        var remoteIdentifier: String? = nil
        var syncDate: Date? = nil
    }
    
    class MockGetCategoryGroupsUseCase: IGetCategoryGroupsUseCase {
        func execute() async throws -> [ILocalCategoryGroup] {
            return [
                MockCategoryGroup(
                    identifier: "1234",
                    name: "Group 1"
                )
            ]
        }
    }
    
    override func setUp() {
        super.setUp()
        
        useCase = MockGetCategoryGroupsUseCase()
    }
    
    func testGetCategoryGroups() async throws {
        let categoryGroups = try await useCase.execute()
        XCTAssertEqual(categoryGroups.count, 1)
        XCTAssertEqual(categoryGroups[0].identifier, "1234")
        XCTAssertEqual(categoryGroups[0].name, "Group 1")
    }
}

class DefaultGetCategoryGroupsUseCaseTests: XCTestCase {
    var useCase: IGetCategoryGroupsUseCase!
    var mockCategoryRepository: ILocalCategoryRepository!
    
    struct CategoryGroup: ILocalCategoryGroup {
        var identifier: String
        var name: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    struct Category: ILocalCategory {
        var identifier: String
        var name: String
        var groupId: String
        var remoteIdentifier: String?
        var syncDate: Date?
    }
    
    class MockLocalCategoryRepository: ILocalCategoryRepository {
        func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
            return [
                CategoryGroup(
                    identifier: "1234",
                    name: "Group 1",
                    remoteIdentifier: nil,
                    syncDate: nil
                )
            ]
        }
        
        func getCategories() async throws -> [ILocalCategory] {
            fatalError()
        }
        
        func getCategory(by name: String) async throws -> DNYK_Core.ILocalCategory {
            fatalError()
        }
        
        func getOrCreateCategoryGroup(name: String) async throws -> DNYK_Core.ILocalCategoryGroup {
            fatalError()
        }
        
        func createCategory(name: String, group: DNYK_Core.ILocalCategoryGroup) async throws -> DNYK_Core.ILocalCategory {
            fatalError()
        }
            
    }
    
    override func setUp() {
        super.setUp()
        
        mockCategoryRepository = MockLocalCategoryRepository()
        useCase = DefaultGetCategoryGroupsUseCase(localRepository: mockCategoryRepository)
    }
    
    func testGetCategoryGroups() async throws {
        let categoryGroups = try await useCase.execute()
        XCTAssertEqual(categoryGroups.count, 1)
        XCTAssertEqual(categoryGroups[0].identifier, "1234")
        XCTAssertEqual(categoryGroups[0].name, "Group 1")
    }
}

