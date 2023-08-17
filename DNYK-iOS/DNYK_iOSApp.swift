//
//  DNYK_iOSApp.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI

@main
struct DNYK_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}

// Can be replaced with other implementations
let defaultDNYKService = DefaultDNYKService.shared
