//
//  AddTransactionViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI
import DNYK_Core

class AddTransactionViewModel: ObservableObject {
    let service: IDNYKService
    // transaction type, either an Expense or Income
    @Published var transactionType: TransactionType = .expense
    @Published var requiredToSelectCategory: Bool = true // this will depend on the account or payee selected (?)
    @Published var amount: String = "0.00"
    @Published var payee: String?
    @Published var selectedCategory: ILocalCategory?
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
        let prefix = selectedCategory == nil ? "Choose " : ""
        return prefix + "Category"
    }
    var accountPlaceholder: String {
        let prefix = account == nil ? "Choose " : ""
        return prefix + "Account"
    }
    
    init(service: IDNYKService) {
        self.service = service
    }
}

extension AddTransactionViewModel: SelectCategoryViewDelegate {
    func getSelectedCategories() -> [ILocalCategory] {
        [self.selectedCategory].compactMap({ $0 })
    }
    func didSelectCategories(_ categories: [ILocalCategory]) {
        self.selectedCategory = categories.first
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
