//
//  SelectCategoryViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

class SelectCategoryViewModel: ObservableObject, CanLoad {
    let service: DNYKService
    
    @Published var isLoading: Bool = false
    @Published var errorMessages: [ErrorMessage] = []
    @Published var categoryGroups: [GroupedCategoriesWrapper] = []
    @Published var searchText: String = ""
    @Published var isSearchPresented: Bool = true
    
    @Published var isMultipleSelection: Bool = false
    @Published var selectedCategories: [CategoryWrapper] = []
    
    init(service: DNYKService) {
        self.service = service
        fetchCategories()
    }
    
    func fetchCategories() {
        Task {
            await self.toggleLoading(true)
            print("Fetching categories...")
            do {
                let groups = try await service.getCategories().map({
                    GroupedCategoriesWrapper(group: $0, isOpened: true)
                })
                await MainActor.run {
                    self.categoryGroups = groups
                }
                print("Loaded: \(self.categoryGroups)")
            } catch {
                let identifier = UUID().uuidString
                let errorMessage = ErrorMessage(identifier: identifier, title: "Error", message: error.localizedDescription)
                await MainActor.run {
                    self.errorMessages.append(errorMessage)
                }
                
                print("Error occured while fetching categories...")
                print(error.localizedDescription)
                print(error)
            }
            await self.toggleLoading(false)
        }
    }
    
    func searchCategories() {
    }
    
    func toggleGroup(_ group: GroupedCategoriesWrapper) {
        guard let index = categoryGroups.firstIndex(where: { $0.id == group.id }) else {
            return
        }
        categoryGroups[index].isOpened.toggle()
    }
    
    func dismissError(with identifier: String) {
        self.errorMessages.removeAll(where: { $0.identifier == identifier })
    }
    
    // MARK: - Wrappers
    
    struct GroupedCategoriesWrapper: Identifiable {
        let id: String
        let group: IGroupedCategories
        let categories: [CategoryWrapper]
        var isOpened: Bool
        
        init(group: IGroupedCategories, isOpened: Bool) {
            self.id = group.identifier
            self.group = group
            self.categories = group.categories.map { category in
                CategoryWrapper(category: category, isSelected: false)
            }
            self.isOpened = isOpened
        }
    }
    
    struct CategoryWrapper: Identifiable {
        let id: String
        let category: any ILocalCategory
        var isSelected: Bool
        
        init(category: ILocalCategory, isSelected: Bool) {
            self.id = category.identifier
            self.category = category
            self.isSelected = isSelected
        }
    }
}

struct ErrorMessage {
    let identifier: String
    let title: String
    let message: String
}
