//
//  AddTransactionDataSourceImpl.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

struct AddTransactionDataSourceImpl: AddTransactionDataSource {
    func saveTransaction(_ transaction: TransactionObject) async {
        print("saveTransaction")
    }
}
