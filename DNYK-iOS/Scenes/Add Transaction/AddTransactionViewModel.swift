//
//  AddTransactionViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI
import DNYK_Core

class AddTransactionViewModel: ObservableObject {
    let service: DNYKService
    // transaction type, either an Expense or Income
    @Published var transactionType: TransactionType = .expense
    @Published var requiredToSelectCategory: Bool = false // this will base on the account or payee selected (?)
    @Published var amount: String = "0.00"
    @Published var payee: String?
    @Published var category: String?
    @Published var account: String?
    @Published var transactionDate: Date = Date()
    @Published var cleared: Bool = true
    @Published var flag: String = "None"
    @Published var memo: String = ""
    @Published var repeatFrequency: String = "Never"
    
    var payeePlaceholder: String {
        let prefix = payee == nil ? "Choose " : ""
        return prefix + transactionType.payeePlaceholder
    }
    var categoryPlaceholder: String {
        if !requiredToSelectCategory {
            return "Category not Needed"
        }
        let prefix = category == nil ? "Choose " : ""
        return prefix + "Category"
    }
    var accountPlaceholder: String {
        let prefix = account == nil ? "Choose " : ""
        return prefix + "Account"
    }
    
    init(service: DNYKService) {
        self.service = service
    }
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
