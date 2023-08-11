//
//  DNYKServiceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

class DNYKServiceImpl: DNYKService {
    lazy var addTransactionDataSource = AddTransactionDataSourceImpl()
    
    lazy var addTransaction = AddTransactionUseCase(dataSource: addTransactionDataSource)
    
    func addTransaction(_ transaction: TransactionObject) async {
        await self.addTransaction.execute(transaction)
    }
}
