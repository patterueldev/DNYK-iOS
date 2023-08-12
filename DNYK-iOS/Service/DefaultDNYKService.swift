//
//  DNYKServiceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

class DefaultDNYKService: DNYKService {
    lazy var addTransactionDataSource = SDTransactionDataSource()
    lazy var addTransaction = DefaultAddTransactionUseCase(repository: addTransactionDataSource)
    
    lazy var getCategoriesDataSource = SDCategoryDataSource()
    lazy var getCategories = DefaultGetCategoriesUseCase(repository: getCategoriesDataSource)
    
    func addTransaction(_ transaction: TransactionModel) async throws{
        try await self.addTransaction.execute(transaction)
    }
    
    func getCategories() async throws -> [CategoryModel] {
        try await getCategories.execute()
    }
}
