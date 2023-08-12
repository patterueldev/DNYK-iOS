//
//  TransactionRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

protocol TransactionRepository {
    func addTransaction(_ transaction: TransactionModel) async throws
}
