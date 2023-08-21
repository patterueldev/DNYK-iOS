//
//  DNYK_iOSApp.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI
import DNYK_Core
import DNYK_SwiftData

@main
struct DNYK_iOSApp: App {
    private var service: DNYKService = {
        let inMemory = CommandLine.arguments.contains("--in-memory")
        return DNYKSwiftData.service(inMemory: inMemory)
    }()
    
    
    var body: some Scene {
        WindowGroup {
            LandingView(service: self.service)
        }
    }
}
