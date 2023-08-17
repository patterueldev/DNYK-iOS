//
//  NewCategoryView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import SwiftUI

struct NewCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var fields: [NewCategoryField] = [
        .init(type: .textField, placeholder: "Enter a Category Name...", value: ""),
        .init(type: .dropdown, placeholder: "Choose Category Group...", value: ""),
    ]
    
//    @State var name: String = ""
//    @State var description: String = ""
    
    var body: some View {
        NavigationStack {
            List(fields) { field in
                switch field.type {
                case .textField:
                    TextField(field.placeholder, text: $fields[0].value)
                        .font(.system(size: 18))
                        .padding(.vertical, 8)
                case .dropdown:
                    Text(field.printed())
                        .foregroundStyle(field.foregroundColor())
                        .font(.system(size: 18))
                        .padding(.vertical, 8)
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

struct NewCategoryField: Identifiable {
    var id: String
    var type: NewCategoryFieldType
    var placeholder: String
    var value: String = ""
    
    init(type: NewCategoryFieldType, placeholder: String, value: String) {
        self.id = UUID().uuidString
        self.type = type
        self.placeholder = placeholder
        self.value = value
    }
    
    func printed() -> String {
        return value.isEmpty ? placeholder : value
    }
    
    func foregroundColor() -> Color {
        return value.isEmpty ? .gray.opacity(0.5) : .black
    }
}

enum NewCategoryFieldType {
    case textField
    case dropdown
}

#Preview {
    return ModalPreview {
        NewCategoryView()
        .interactiveDismissDisabled()
    }
}
