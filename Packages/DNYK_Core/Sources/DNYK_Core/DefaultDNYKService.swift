//
//  DNYKServiceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation
import SwiftData

public class DefaultDNYKService: DNYKService {
    public static var preview: DefaultDNYKService = {
        let service = DefaultDNYKService(
            transactionRepository: PreviewTransactionDataSource(),
            localCategoryRepository: PreviewCategoryDataSource()
        )
        return service
    }()
    
    private let addTransactionDataSource: TransactionRepository
    private let localCategoryRepository: ILocalCategoryRepository
    
    private lazy var addTransaction = DefaultAddTransactionUseCase(repository: addTransactionDataSource)
    
    private lazy var getCategories = DefaultGetCategoriesUseCase(localRepository: localCategoryRepository)
    private lazy var getGroups = DefaultGetCategoryGroupsUseCase(localRepository: localCategoryRepository)
    private lazy var createCategory = DefaultCreateCategoryUseCase(localRepository: localCategoryRepository)
    
    public init(
        transactionRepository: TransactionRepository,
        localCategoryRepository: ILocalCategoryRepository
    ) {
        self.addTransactionDataSource = transactionRepository
        self.localCategoryRepository = localCategoryRepository
    }
    
    
    public func addTransaction(_ transaction: ITransaction) async throws{
        try await self.addTransaction.execute(transaction)
    }
    
    public func getCategories() async throws -> [LocalGroupedCategories] {
        try await getCategories.execute()
    }
    
    public func getCategoryGroups() async throws -> [ILocalCategoryGroup] {
        try await getGroups.execute()
    }
    
    public func createCategory(name: String, group: String) async throws -> ICategory {
        try await createCategory.execute(name: name, group: group)
    }
}
