//
//  DNYKServiceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation
import SwiftData

public class DefaultDNYKService: DNYKService {
    public static var shared = DefaultDNYKService()
    public static var preview: DefaultDNYKService = {
        let localCategoryRepository = PreviewCategoryDataSource()
        let service = DefaultDNYKService(localCategoryRepository: localCategoryRepository)
        return service
    }()
    
    private lazy var addTransactionDataSource = SDTransactionDataSource()
    private lazy var addTransaction = DefaultAddTransactionUseCase(repository: addTransactionDataSource)
    
    private let localCategoryRepository: ILocalCategoryRepository
    private lazy var getCategories = DefaultGetCategoriesUseCase(localRepository: localCategoryRepository)
    private lazy var getGroups = DefaultGetCategoryGroupsUseCase(localRepository: localCategoryRepository)
    private lazy var createCategory = DefaultCreateCategoryUseCase(localRepository: localCategoryRepository)
    
    private init() {
        do {
            let types: [any PersistentModel.Type] = [
                SDCategoryModel.self,
                SDCategoryGroupModel.self,
            ]
            let modelContainer = try ModelContainer(for: types)
            localCategoryRepository = SDCategoryDataSource(container: modelContainer)
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    private init(localCategoryRepository: ILocalCategoryRepository) {
        self.localCategoryRepository = localCategoryRepository
    }
    
    
    public func addTransaction(_ transaction: ITransaction) async throws{
        try await self.addTransaction.execute(transaction)
    }
    
    public func getCategories() async throws -> [IGroupedCategories] {
        try await getCategories.execute()
    }
    
    public func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
        try await getGroups.execute()
    }
    
    public func createCategory(name: String, group: String) async throws -> ICategory {
        try await createCategory.execute(name: name, group: group)
    }
}
