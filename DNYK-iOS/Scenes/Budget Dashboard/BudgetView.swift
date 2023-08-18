//
//  BudgetView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/11/23.
//

import SwiftUI
import SFSafeSymbols
import DNYK_Core

struct BudgetView: View {
    let service: DNYKService
    init(service: DNYKService) {
        self.service = service
    }
    
    @State var showsAddTransaction = false
     
    var body: some View {
        ZStack {
            VStack {
                // Your main content goes here
                Text(DNYKCore.text)
                
                Spacer() // Spacer to push content to the top
                HStack {
                    Spacer()
                    Button(action: {
                        showsAddTransaction = true
                    }, label: {
                        Image(systemSymbol: .plusCircleFill)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                    }).padding()
                }
            }
        }.sheet(isPresented: $showsAddTransaction, content: {
            AddTransactionView(service: service)
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    LandingView(service: DefaultDNYKService.preview)
}
