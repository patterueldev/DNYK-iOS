//
//  PreviewDNYKService.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

class PreviewDNYKService: DNYKService {
    static var shared = PreviewDNYKService()
    
    lazy var addTransactionDataSource: TransactionRepository = {
        fatalError()
    }()
    lazy var addTransaction = DefaultAddTransactionUseCase(repository: addTransactionDataSource)
    
    lazy var getCategoriesDataSource = PreviewCategoryDataSource()
    lazy var getCategories = DefaultGetCategoriesUseCase(repository: getCategoriesDataSource)
    
    private init() {}
    
    func setup() throws {
        
    }
    
    func addTransaction(_ transaction: ITransaction) async throws{
        try await self.addTransaction.execute(transaction)
    }
    
    func getCategories() async throws -> [IGroupedCategories] {
        try await getCategories.execute()
    }

}
