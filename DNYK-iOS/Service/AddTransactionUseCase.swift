//
//  AddTransactionUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

struct AddTransactionUseCase {
    let dataSource: AddTransactionDataSource
    init(dataSource: AddTransactionDataSource) {
        self.dataSource = dataSource
    }
    
    func execute(_ parameters: TransactionObject) async {
        await dataSource.saveTransaction(parameters)
    }
}
