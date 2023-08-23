//
//  AddTransactionView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI
import SwiftDate
import SFSafeSymbols
import DNYK_Core

typealias OptionsLoader = () async -> [String]

struct AddTransactionView: View {
    init(service: IDNYKService) {
        self.viewModel = AddTransactionViewModel(service: service)
    }
    
    @ObservedObject var viewModel: AddTransactionViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    transactionTypeSegment()
                    amountField()
                    payeeField()
                    categoryField()
                    accountField()
                    dateField()
                    clearedField()
                    flagField()
                    memoField()
                    repeatField()
                    // add a fixed space to push the content up
                    Spacer(minLength: 69)
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
    
    private func dropdownField(
        iconSymbol: SFSymbol,
        placeholder: String,
        value: String?,
        displaysChevron: Bool
    ) -> some View {
        HStack {
            Image(systemSymbol: iconSymbol)
                .foregroundStyle(value != nil ? .blue : .gray)
                .padding(.trailing, 10)
            VStack(alignment: .leading){
                Text(placeholder)
                    .foregroundStyle(.gray)
                    .font(.system(size: 18))
                if let value {
                    Text(value)
                        .foregroundStyle(.black)
                }
            }
            Spacer()
            if (displaysChevron) {
                Image(systemSymbol: .chevronDown) // for test
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 69, alignment: .center)
        .background(Color.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func payeeField() -> some View {
        self.dropdownField(
            iconSymbol: .personFill,
            placeholder: viewModel.payeePlaceholder,
            value: viewModel.payee,
            displaysChevron: true
        )
    }
    
    private func categoryField() -> some View {
        NavigationLink(destination: SelectCategoryView(service: viewModel.service, delegate: viewModel)) {
            self.dropdownField(
                iconSymbol: .squareGrid2x2,
                placeholder: viewModel.categoryPlaceholder,
                value: viewModel.selectedCategory?.name,
                displaysChevron: viewModel.requiredToSelectCategory)
        }
        .accessibilityLabel("Choose Category")
    }
    
    private func accountField() -> some View {
        self.dropdownField(
            iconSymbol: .creditcardFill,
            placeholder: viewModel.accountPlaceholder,
            value: viewModel.account,
            displaysChevron: true
        )
    }
    
    private func dateField() -> some View {
        let transactionDate = viewModel.transactionDate.toString(.custom("MMMM dd, yyyy"))
        return self.dropdownField(
            iconSymbol: .calendar,
            placeholder: "Date",
            value: transactionDate,
            displaysChevron: false
        )
    }
    
    private func clearedField() -> some View {
        HStack {
            Image(systemSymbol: .clearFill)
                .foregroundStyle(viewModel.cleared ? .green : .gray)
                .padding(.trailing, 10)
            VStack(alignment: .leading){
                Text("Cleared")
                    .foregroundStyle(.gray)
                    .font(.system(size: 18))
            }
            Spacer()
            // UISwitch SwiftUI counterpart
            Toggle("", isOn: $viewModel.cleared)
                .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 69, alignment: .center)
        .background(Color.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func flagField() -> some View {
        self.dropdownField(
            iconSymbol: .flagFill,
            placeholder: "Flag",
            value: viewModel.flag,
            displaysChevron: false
        )
    }
    
    private func memoField() -> some View {
        HStack {
            Image(systemSymbol: .note)
                .foregroundStyle(viewModel.memo != "" ? .blue : .gray)
                .padding(.trailing, 10)
            VStack(alignment: .leading){
                TextField("Enter a memo...", text: $viewModel.memo)
                    .font(.system(size: 18))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 69, alignment: .center)
        .background(Color.white.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func repeatField() -> some View {
        self.dropdownField(
            iconSymbol: .repeat,
            placeholder: "Repeat",
            value: viewModel.repeatFrequency,
            displaysChevron: true
        )
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
                        Image(systemSymbol: .checkmarkCircleFill)
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

#Preview {
    ModalPreview(content: {
        AddTransactionView(service: DefaultDNYKService.preview)
            .interactiveDismissDisabled()
    })
}
