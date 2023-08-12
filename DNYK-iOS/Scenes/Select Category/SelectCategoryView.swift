//
//  SelectCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI

struct SelectCategoryView: View {
    @ObservedObject var viewModel = SelectCategoryViewModel()
    
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
                    List(viewModel.categories) { category in
                        Button(action: {
                            viewModel.selectedCategories.append(category.category)
                        }) {
                            HStack {
                                Text(category.category.name)
                                Spacer()
                                if category.isSelected {
                                    Image(systemSymbol: .checkmarkCircleFill)
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemSymbol: .circle)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                
                
                }
                
            }
            .navigationBarTitle("Category", displayMode: .inline)
            .background(.white)
        }
    }
}

#Preview {
    // in this preview, there must be a customized service to provide dummy data
    let viewModel = SelectCategoryViewModel(categories: [
        SDCategoryModel(id: "0", name: "Inflow")
    ])
    return ModalPreview {
        SelectCategoryView(viewModel: viewModel)
        .interactiveDismissDisabled()
    }
}

