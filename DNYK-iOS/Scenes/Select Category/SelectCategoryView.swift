//
//  SelectCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/12/23.
//

import SwiftUI
import DNYK_Core

struct SelectCategoryView: View {
    init(service: IDNYKService, delegate: SelectCategoryViewDelegate? = nil) {
        self.viewModel = SelectCategoryViewModel(service: service, delegate: delegate)
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SelectCategoryViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TextField("Search", text: $viewModel.searchText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    Section {
                        NavigationLink(destination: DNYKViewBuilder.newCategoryView(with: viewModel.service)) {
                            HStack {
                                Image(systemSymbol: .plusCircleFill)
                                    .foregroundColor(.blue)
                                Text("New Category")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Spacer()
                            }.padding(.horizontal, 16)
                        }
                    }
                    List(viewModel.categoryGroups) { categoryGroup in
                        Section {
                            HStack {
                                Text(categoryGroup.group.name)
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                Spacer()
                                
                                let image = categoryGroup.isOpened ? Image(systemSymbol: .chevronDown) : Image(systemSymbol: .chevronUp)
                                Button(action: {
                                    viewModel.toggleGroup(categoryGroup)
                                }) {
                                    image
                                        .foregroundColor(.black)
                                }
                            }
                            
                            if categoryGroup.isOpened {
                                ForEach(categoryGroup.categories) { category in
                                    Button(action: {
                                        viewModel.toggleCategory(category)
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        HStack {
                                            Text(category.category.name)
                                                .foregroundColor(.black)
                                                .padding(.vertical, 6)
                                            Spacer()
                                            if viewModel.selectedCategories.contains(where: { $0.id == category.id }) {
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
                    }.background(Color.clear)
                }
                .navigationBarTitle("Category", displayMode: .inline)
                .background(.white)
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4) // Dim the background
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5, anchor: .center) // Adjust the scale as needed
                            .padding()
                        Text("Loading...")
                            .foregroundColor(.white)
                    }
                }
                if !viewModel.errorMessages.isEmpty {
                    
                }
            }
        }
        .onAppear() {
            viewModel.fetchCategories()
        }
    }
}

#Preview {
    return ModalPreview {
        SelectCategoryView(service: DefaultDNYKService.preview)
            .interactiveDismissDisabled()
    }
}

