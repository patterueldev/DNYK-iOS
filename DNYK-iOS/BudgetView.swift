//
//  BudgetView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI

struct BudgetView: View {
    @State var showsAddTransaction = false
    @ObservedObject var addTransactionViewModel = AddTransactionViewModel()
     
    var body: some View {
        ZStack {
            VStack {
                // Your main content goes here
                Text("Hello, worl!")
                
                Spacer() // Spacer to push content to the top
                HStack {
                    Spacer()
                    Button(action: {
                        showsAddTransaction = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                    }).padding()
                }
            }
        }.sheet(isPresented: $showsAddTransaction, content: {
            AddTransactionView(viewModel: addTransactionViewModel)
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    LandingView()
}
