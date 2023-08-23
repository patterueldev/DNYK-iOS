//
//  AddTransactionUseCase.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import Foundation

protocol IAddTransactionUseCase {
    func execute(_ parameters: ITransaction) async throws
}

struct DefaultAddTransactionUseCase {
    private let repository: ITransactionRepository
    
    init(repository: ITransactionRepository) {
        self.repository = repository
    }
    
    func execute(_ parameters: ITransaction) async throws {
        try await repository.addTransaction(parameters)
    }
}
