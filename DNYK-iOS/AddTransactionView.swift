//
//  AddTransactionView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI

typealias OptionsLoader = () async -> [String]

private enum Field {
    case transactionTypeField
    case amountField
    case payeeField
}
struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddTransactionViewModel
    
    @State private var fields: [Field] = [
        .transactionTypeField,
        .amountField,
        .payeeField
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(fields, id: \.self) { field in
                        switch field {
                        case .transactionTypeField:
                            transactionTypeSegment()
                        case .amountField:
                            amountField()
                        case .payeeField:
                            payeeField()
                        }
                    }
                }.padding(10)
            }
            .overlay(content: floatingButtonContainer)
            .navigationBarTitle("Add Transaction", displayMode: .inline)
            .background(
                viewModel.transactionType.color
                    .animation(.easeInOut(duration: 0.25))
            )
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    private func transactionTypeSegment() -> some View {
        let options = TransactionType.allCases
        return Picker("Segment", selection: $viewModel.transactionType) {
            ForEach(options, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private func amountField() -> some View {
        // textfield with transparent background
        TextField("", text: .constant("0.00"))
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func payeeField() -> some View {
        // just a selection field that displays the text
        // check if payee is nil, if not nil, display value and placeholder (tiny)
        HStack {
            VStack(alignment: .leading){
                Text(viewModel.payeePlaceholder)
                    .foregroundStyle(.gray)
                    .font(.system(size: 18))
                if (viewModel.payee != nil) {
                    Text(viewModel.payee!)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 69, alignment: .center)
        .background(Color.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func floatingButtonContainer() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Save")
                    }
                })
                .padding(.vertical, 15) // Set vertical padding to 10
                .padding(.horizontal, 30) // Set horizontal padding to 20
                .background(Color.blue)
                .clipShape(Capsule())
                .foregroundStyle(.white)
                .padding()
            }
        }
    }
}

//private enum Field {
//    case segment(options: OptionsLoader, selectedIndex: Int)
//    case amount(currency: String, amount: Double)
//    case dropdown(label: String, options: OptionsLoader, selectedIndex: Int?)
//    case date(label: String, date: Date?)
//    
//    case toggle(label: String)
//    case text(label: String)
//}

private struct ModalPreview : View {
    @State var showsAddTransaction = true
    @ObservedObject var addTransactionViewModel = AddTransactionViewModel()
    
    var body: some View {
        Text("Preview")
            .sheet(isPresented: $showsAddTransaction, content: {
                AddTransactionView(viewModel: addTransactionViewModel)
                    .interactiveDismissDisabled()
            })
    }
}



#Preview {
    ModalPreview(showsAddTransaction: true)
}
