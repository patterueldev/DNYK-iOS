//
//  AddTransactionViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI

class AddTransactionViewModel: ObservableObject {
    // transaction type, either an Expense or Income
    @Published var transactionType: TransactionType = .expense
    var payeePlaceholder: String {
        let prefix = payee == nil ? "Choose " : ""
        return prefix + transactionType.payeePlaceholder
    }
    @Published var amount: String = "0.00"
    @Published var payee: String?
}

enum TransactionType: String, CaseIterable {
    case expense = "Expense"
    case income = "Income"
    
    var color: Color {
        switch self {
        case .expense:
            return Color.fromHex("FFAAAA")
        case .income:
            return Color.fromHex("AAFFAA")
        }
    }
    
    var payeePlaceholder: String {
        switch self {
        case .expense:
            return "Recipient"
        case .income:
            return "Client"
        }
    }
}
