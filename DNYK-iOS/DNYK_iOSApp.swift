//
//  DNYK_iOSApp.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/10/23.
//

import SwiftUI
import DNYK_Core

@main
struct DNYK_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView(service: DefaultDNYKService.shared)
        }
    }
}
