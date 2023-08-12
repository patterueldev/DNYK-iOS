//
//  SelectCategoryViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

class SelectCategoryViewModel: ObservableObject {
    struct CategoryWrapper: Identifiable {
        let id: String
        let category: any CategoryModel
        let isSelected: Bool
        
        init(category: CategoryModel, isSelected: Bool) {
            self.id = category.id
            self.category = category
            self.isSelected = isSelected
        }
    }
    
    let service: DNYKService = DefaultDNYKService.shared
    
    @Published var isLoading: Bool = false
    @Published var errorMessages: [ErrorMessage] = []
    @Published var categories: [CategoryWrapper] = []
    @Published var searchText: String = ""
    @Published var isSearchPresented: Bool = true
    
    @Published var selectedCategories: [CategoryModel] = []
    
    init(categories: [CategoryModel] = []){
        self.categories = categories.map({ CategoryWrapper(category: $0, isSelected: false) })
        fetchCategories()
    }
    
    func fetchCategories() {
        Task {
            self.isLoading = true
            do {
                self.categories = try await service.getCategories().map({
                    CategoryWrapper(category: $0, isSelected: selectedCategories.contains(where: { $0.id == $0.id }))
                })
            } catch {
                let identifier = UUID().uuidString
                let errorMessage = ErrorMessage(identifier: identifier, title: "Error", message: error.localizedDescription)
                self.errorMessages.append(errorMessage)
            }
            self.isLoading = false
        }
    }
    
    func searchCategories() {
        
    }
    
    func dismissError(with identifier: String) {
        self.errorMessages.removeAll(where: { $0.identifier == identifier })
    }
}

struct ErrorMessage {
    let identifier: String
    let title: String
    let message: String
}
