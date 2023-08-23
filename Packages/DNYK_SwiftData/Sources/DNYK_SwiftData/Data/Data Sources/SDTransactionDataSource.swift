//
//  SDTransactionDataSource.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import Foundation
import DNYK_Core

class SDTransactionDataSource: ITransactionRepository {
    func addTransaction(_ transaction: ITransaction) async throws {
        // TODO:
        throw NSError(domain: "SDTransactionDataSource", code: 1, userInfo: nil)
    }
}

