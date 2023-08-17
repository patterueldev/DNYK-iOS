//
//  DNYKServiceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation
import SwiftData

class DefaultDNYKService: DNYKService {
    static var shared = DefaultDNYKService()
    
    private var modelContainer: ModelContainer
    
    private lazy var addTransactionDataSource = SDTransactionDataSource()
    private lazy var addTransaction = DefaultAddTransactionUseCase(repository: addTransactionDataSource)
    
    private lazy var getCategoriesDataSource = SDCategoryDataSource(container: modelContainer)
    private lazy var getCategories = DefaultGetCategoriesUseCase(repository: getCategoriesDataSource)
    
    private init() {
        do {
            modelContainer = try ModelContainer(for: [SDCategoryModel.self])
        } catch {
            fatalError("Failed to initialize model container")
        }
    }
    
    func addTransaction(_ transaction: ITransaction) async throws{
        try await self.addTransaction.execute(transaction)
    }
    
    func getCategories() async throws -> [IGroupedCategories] {
        try await getCategories.execute()
    }
}
