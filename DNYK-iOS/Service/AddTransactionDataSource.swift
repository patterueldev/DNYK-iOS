//
//  AddTransactionDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

protocol AddTransactionDataSource {
    func saveTransaction(_ transaction: TransactionObject) async
}
