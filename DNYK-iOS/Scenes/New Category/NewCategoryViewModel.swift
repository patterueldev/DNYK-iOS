//
//  NewCategoryViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI

class NewCategoryViewModel: ObservableObject {
    let service: DNYKService
    
    @Published var isLoading: Bool = false
    @Published var errorMessages: [ErrorMessage] = []
    @Published var categoryGroups: [CategoryGroupWrapper] = []
    
    @Published var name: String = ""
    @Published var group: CategoryGroupWrapper?
    
    @State var fields: [NewCategoryField] = [
        .init(id: 0, type: .textField, property: .name, placeholder: "Enter a Category Name..."),
        .init(id: 1, type: .dropdown, property: .group, placeholder: "Choose Category Group..."),
    ]
    
    init(service: DNYKService = defaultDNYKService) {
        self.service = service
        fetchCategoryGroups()
    }
    
    func fetchCategoryGroups() {
        Task {
            self.isLoading = true
            print("Fetching category groups...")
            do {
                self.categoryGroups = try await service.getCategoryGroups().map {
                    CategoryGroupWrapper(group: $0)
                }
                print("Loaded: \(self.categoryGroups)")
            } catch {
                let identifier = UUID().uuidString
                let errorMessage = ErrorMessage(identifier: identifier, title: "Error", message: error.localizedDescription)
                self.errorMessages.append(errorMessage)
            }
            self.isLoading = false
        }
    }
    
    struct CategoryGroupWrapper: Identifiable, Hashable {
        
        let id: String
        let name: String
        let group: ICategoryGroup
        
        init(group: ICategoryGroup) {
            self.id = group.identifier
            self.name = group.name
            self.group = group
        }
        
        static func == (lhs: NewCategoryViewModel.CategoryGroupWrapper, rhs: NewCategoryViewModel.CategoryGroupWrapper) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}

struct NewCategoryField: Identifiable {
    let id: Int // this will be the index of the array
    let type: NewCategoryFieldType
    let property: NewCategoryProperty
    let placeholder: String
    
    init(id: Int, type: NewCategoryFieldType, property: NewCategoryProperty, placeholder: String) {
        self.id = id
        self.type = type
        self.property = property
        self.placeholder = placeholder
    }
}

enum NewCategoryFieldType {
    case textField
    case dropdown
}

enum NewCategoryProperty {
    case name
    case group
}
