//
//  SelectCategoryViewModel.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

class SelectCategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var searchText: String = ""
    @Published var isSearchPresented: Bool = true
    
    @Published var selectedCategories: [Category] = []
    
    func searchCategories() {
        
    }
}
