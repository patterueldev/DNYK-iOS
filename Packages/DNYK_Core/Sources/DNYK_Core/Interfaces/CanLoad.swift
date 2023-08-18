//
//  CanLoad.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/18/23.
//

import Foundation

public protocol CanLoad: ObservableObject {
    var isLoading: Bool { get set }
}

public extension CanLoad {
    func toggleLoading(_ isLoading: Bool? = nil) async {
        await MainActor.run {
            self.isLoading = isLoading ?? !self.isLoading
        }
    }
}

