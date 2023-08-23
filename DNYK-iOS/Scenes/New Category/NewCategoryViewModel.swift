//
//  NewCategoryViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI
import DNYK_Core

protocol INewCategoryViewModel: ObservableObject, ICanLoad {
    // MARK: - Properties
    var name: String { get set }
    var selectedGroup: NewCategoryViewModel.CategoryGroupWrapper { get set }
    var groupName: String { get set }
    
    // MARK: - Selections
    var fields: [NewCategoryField] { get set }
    var categoryGroups: [NewCategoryViewModel.CategoryGroupWrapper] { get set }
    
    // MARK: - State
    var isSaveButtonEnabled: Bool { get }
    
    // MARK: - Methods
    func save(completion: @escaping (Bool) -> Void)
}

class NewCategoryViewModel: INewCategoryViewModel {
    let service: IDNYKService
    
    @Published var isLoading: Bool = false
    @Published var errorMessages: [ErrorMessage] = []
    @Published var categoryGroups: [CategoryGroupWrapper] = [.unselected(), .createNew()]
    
    @Published var name: String = ""
    @Published var selectedGroup: CategoryGroupWrapper = .unselected()
    @Published var groupName: String = ""
    
    @State var fields: [NewCategoryField] = [
        .init(property: .name, placeholder: "Enter a Category Name..."),
        .init(property: .group, placeholder: "Choose Category Group..."),
        .init(property: .groupName, placeholder: "Enter a Category Group Name...")
    ]
    
    var isSaveButtonEnabled: Bool {
        let condition = [
            !isLoading,
            !name.isEmptyAfterTrimming,
            !selectedGroup.isUnselected,
            selectedGroup.isCreateNew ? !groupName.isEmptyAfterTrimming : true
        ]
        return condition.allSatisfy { $0 }
    }
    
    init(service: IDNYKService) {
        self.service = service
        fetchCategoryGroups()
    }
    
    func fetchCategoryGroups() {
        Task {
            await self.toggleLoading(true)
            print("Fetching category groups...")
            do {
                let groups: [CategoryGroupWrapper] = try await [.unselected(), .createNew()] + service.getCategoryGroups().map {
                    .init(group: $0)
                }
                await MainActor.run {
                    self.categoryGroups = groups
                }
                
                print("Loaded: \(self.categoryGroups)")
            } catch {
                let identifier = UUID().uuidString
                let errorMessage = ErrorMessage(identifier: identifier, title: "Error", message: error.localizedDescription)
                self.errorMessages.append(errorMessage)
            }
            await self.toggleLoading(false)
        }
    }
    
    func save(completion: @escaping (Bool) -> Void) {
        Task {
            await self.toggleLoading(true)
            print("Saving category...")
            var didSucceed = false
            do {
                guard let name = self.name.nullIfEmpty else {
                    throw ValidationError.emptyCategoryName
                }
                let rawGroupName = selectedGroup.isCreateNew ? self.groupName : selectedGroup.name
                guard let groupName = rawGroupName.nullIfEmpty else {
                    throw ValidationError.emptyCategoryGroupName
                }
                
                try await service.createCategory(name: name, group: groupName)
                didSucceed = true
            } catch {
                let identifier = UUID().uuidString
                let errorMessage = ErrorMessage(identifier: identifier, title: "Error", message: error.localizedDescription)
                await MainActor.run {
                    self.errorMessages.append(errorMessage)
                }
            
            }
            await self.toggleLoading(false)
            let succeed = didSucceed
            await MainActor.run {
                completion(succeed)
            }
        }
    }
    
    struct CategoryGroupWrapper: Identifiable, Hashable {
        
        let id: String
        let name: String
        let isUnselected: Bool
        let isCreateNew: Bool
        let group: ICategoryGroup?
        
        init(_ selectionType: GroupSelectionType) {
            self.isUnselected = selectionType.isUnselected()
            self.isCreateNew = selectionType.isCreateNew()
            self.group = selectionType.group()
            switch selectionType {
            case .unselected:
                self.id = "unselected"
                self.name = "Select a Group..."
            case .create:
                self.id = "createnew"
                self.name = "Create new group"
            case .group(let group):
                self.id = group.identifier
                self.name = group.name
            }
        }
        
        static func unselected() -> CategoryGroupWrapper {
            return CategoryGroupWrapper(.unselected)
        }
        
        static func createNew() -> CategoryGroupWrapper {
            return CategoryGroupWrapper(.create)
        }
        
        init(group: ICategoryGroup) {
            self.init(.group(group))
        }
        
        static func == (lhs: NewCategoryViewModel.CategoryGroupWrapper, rhs: NewCategoryViewModel.CategoryGroupWrapper) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    enum GroupSelectionType {
        case unselected, create, group(ICategoryGroup)
        
        func isUnselected() -> Bool {
            switch self {
            case .unselected:
                return true
            default:
                return false
            }
        }
        
        func isCreateNew() -> Bool {
            switch self {
            case .create:
                return true
            default:
                return false
            }
        }
        
        func group() -> ICategoryGroup? {
            switch self {
            case .group(let group):
                return group
            default:
                return nil
            }
        }
    }
    
    enum ValidationError: Error {
        case emptyCategoryGroupName
        case emptyCategoryName
        
        var localizedDescription: String {
            switch self {
            case .emptyCategoryGroupName:
                return "Category Group Name is required."
            case .emptyCategoryName:
                return "Category Name is required."
            }
        }
    }
}

struct NewCategoryField: Identifiable {
    let id: Int // this will be the index of the array
    let property: NewCategoryProperty
    let placeholder: String
    
    init(property: NewCategoryProperty, placeholder: String) {
        self.id = property.rawValue
        self.property = property
        self.placeholder = placeholder
    }
}

enum NewCategoryProperty: Int {
    case name
    case group
    case groupName
}
