//
//  NewCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI

struct NewCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = NewCategoryViewModel()
    
    @State var groupPickerVisible: Bool = false
    @State var selectedGroup: String = ""
 
//    @State var name: String = ""
//    @State var description: String = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.fields) { field in
                switch field.type {
                case .textField:
                    TextField(field.placeholder, text: $viewModel.name)
                        .font(.system(size: 18))
                        .padding(.vertical, 8)
                case .dropdown:
                    Picker(field.placeholder, selection: $viewModel.group, content: {
                        ForEach(viewModel.categoryGroups) { group in
                            Text(group.name)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .foregroundStyle(Color.white, Color.white, Color.white)
                    .tint(Color.white)
                    .overlay {
                        HStack {
                            Text(field.placeholder)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 18))
                            Spacer()
                            Image(systemSymbol: .chevronRight)
                                .foregroundStyle(.gray.opacity(0.5))
                        }.backgroundStyle(Color.white)
                    }
                }
            }
            .navigationBarTitle("New Category", displayMode: .inline)
            .background(.white)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.disabled(true)
                }
            }
        }
    }
}

#Preview {
    return ModalPreview {
        NewCategoryView()
        .interactiveDismissDisabled()
    }
}
