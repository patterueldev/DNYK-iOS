//
//  NewCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI
import DNYK_Core

struct NewCategoryView<ViewModel: INewCategoryViewModel>: View {
    typealias Identifiers = Constants.AccessibilityIdentifiers
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            buildFields()
        }
    }
    
    func buildFields() -> some View {
        ScrollView {
            VStack {
                nameTextField()
                groupPickerField()
                if viewModel.selectedGroup.isCreateNew {
                    newGroupTextField()
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
        }
        .navigationBarTitle("New Category", displayMode: .inline)
        .background(Color.fromHex("#F2F2F7"))
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
                }
                .disabled(!viewModel.isSaveButtonEnabled)
                .accessibilityIdentifier(Identifiers.newCategoryViewSaveButton)
            }
        }
    }
    
    func fieldWrapper(_ view: () -> some View) -> some View {
        view()
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.bottom, 8)
    }
    
    func nameTextField() -> some View {
        fieldWrapper {
            TextField("Enter a Category Name...", text: $viewModel.name)
                .font(.system(size: 18))
                .padding(.vertical, 8)
                .accessibilityIdentifier(Identifiers.newCategoryViewNameTextField)
        }
    }
    
    func groupPickerField() -> some View {
        fieldWrapper {
            Picker("", selection: $viewModel.selectedGroup, content: {
                ForEach(viewModel.categoryGroups) { group in
                    Text(group.name)
                        .tag(group)
                }
            })
            .accessibilityIdentifier(Identifiers.newCategoryViewGroupField)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 2)
            .foregroundStyle(Color.white, Color.white, Color.white)
            .tint(Color.white)
            .overlay {
                HStack {
                    let group = viewModel.selectedGroup
                    let unselected = group.isUnselected
                    let text = unselected ? "Choose Category Group..." : group.name
                    let color = unselected ? Color.gray.opacity(0.5) : Color.black
                    
                    Text(text)
                        .foregroundStyle(color)
                        .font(.system(size: 18))
                    Spacer()
                    Image(systemSymbol: .chevronRight)
                        .foregroundStyle(.gray.opacity(0.5))
                }.backgroundStyle(Color.white)
            }
        }
    }
    
    func newGroupTextField() -> some View {
        fieldWrapper {
            TextField("Enter a Category Group Name...", text: $viewModel.groupName)
                .font(.system(size: 18))
                .padding(.vertical, 8)
                .accessibilityIdentifier(Identifiers.newCategoryViewNewGroupTextField)
        }
    }
}

#Preview {
    return ModalPreview {
        DNYKViewBuilder.newCategoryView(with: DefaultDNYKService.preview)
    }
}
