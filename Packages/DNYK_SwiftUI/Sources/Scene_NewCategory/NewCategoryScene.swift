//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/23/23.
//

import SwiftUI
import DNYK_Core

public struct NewCategoryScene {
    private init() { fatalError("Initializer should not be used") }
    
    public static func view(with service: IDNYKService) -> some View {
        NewCategoryView(
            viewModel: NewCategoryViewModel(
                service: service
            )
        )
    }
}
