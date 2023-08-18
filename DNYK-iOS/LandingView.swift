//
//  LandingView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI
import SFSafeSymbols

struct LandingView: View {
    let service: DNYKService
    init(service: DNYKService) {
        self.service = service
    }
    
    var body: some View {
        TabView {
            // First Tab
            BudgetView(service: service)
                .tabItem {
                    Image(systemSymbol: .dollarsignSquareFill)
                    Text("Budget")
                }
            
            // Second Tab
            Text("Second Tab Content")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }
            
            // Add more tabs as needed
        }
    }
}

#Preview {
    LandingView(service: DefaultDNYKService.preview)
}
