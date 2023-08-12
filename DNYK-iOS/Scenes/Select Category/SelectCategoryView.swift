//
//  SelectCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

struct SelectCategoryView: View {
    @ObservedObject var viewModel: SelectCategoryViewModel = SelectCategoryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                ScrollView {
                    
                }
                
            }
            .navigationBarTitle("Category", displayMode: .inline)
            .background(.white)
        }
    }
}

#Preview {
    ModalPreview {
        SelectCategoryView()
        .interactiveDismissDisabled()
    }
}

