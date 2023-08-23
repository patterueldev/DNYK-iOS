//
//  CanLoad.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/18/23.
//

import Foundation

public protocol ICanLoad: ObservableObject {
    var isLoading: Bool { get set }
}

public extension ICanLoad {
    func toggleLoading(_ isLoading: Bool? = nil) async {
        await MainActor.run {
            self.isLoading = isLoading ?? !self.isLoading
        }
    }
}

