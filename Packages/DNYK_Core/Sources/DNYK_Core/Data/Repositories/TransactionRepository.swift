//
//  TransactionRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation

public protocol TransactionRepository {
    func addTransaction(_ transaction: ITransaction) async throws
}

