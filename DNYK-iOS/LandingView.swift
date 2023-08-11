//
//  LandingView.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        TabView {
            // First Tab
            BudgetView()
                .tabItem {
                    Image(systemName: "dollarsign.square")
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
    LandingView()
}
