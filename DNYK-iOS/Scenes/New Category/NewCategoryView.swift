//
//  NewCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI
import DNYK_Core

struct NewCategoryView: View {
    init(service: DNYKService) {
        self.viewModel = NewCategoryViewModel(service: service)
    }

    @ObservedObject var viewModel: NewCategoryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            List(viewModel.fields) { field in
                switch field.property {
                case .name:
                    TextField(field.placeholder, text: $viewModel.name)
                        .font(.system(size: 18))
                        .padding(.vertical, 8)
                case .group:
                    Picker(field.placeholder, selection: $viewModel.selectedGroup, content: {
                        ForEach(viewModel.categoryGroups) { group in
                            Text(group.name)
                                .tag(group)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .foregroundStyle(Color.white, Color.white, Color.white)
                    .tint(Color.white)
                    .overlay {
                        HStack {
                            let group = viewModel.selectedGroup
                            let unselected = group.isUnselected
                            let text = unselected ? field.placeholder : group.name
                            let color = unselected ? Color.gray.opacity(0.5) : Color.black
                            
                            Text(text)
                                .foregroundStyle(color)
                                .font(.system(size: 18))
                            Spacer()
                            Image(systemSymbol: .chevronRight)
                                .foregroundStyle(.gray.opacity(0.5))
                        }.backgroundStyle(Color.white)
                    }
                case .groupName:
                    if(viewModel.selectedGroup.isCreateNew) {
                        TextField(field.placeholder, text: $viewModel.groupName)
                            .font(.system(size: 18))
                            .padding(.vertical, 8)
                    }
                }
            }
            .navigationBarTitle("New Category", displayMode: .inline)
            .background(.white)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.save { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }.disabled(!viewModel.isSaveButtonEnabled)
                }
            }
        }
    }
}

#Preview {
    return ModalPreview {
        SelectCategoryView(service: DefaultDNYKService.preview)
//        NewCategoryView(service: DefaultDNYKService.preview)
    }
}
