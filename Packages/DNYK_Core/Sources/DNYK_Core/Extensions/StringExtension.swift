//
//  StringExtension.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/18/23.
//

import Foundation

public extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var nullIfEmpty: String? {
        return self.isEmptyAfterTrimming ? nil : self
    }

    var isEmptyAfterTrimming: Bool {
        return self.trimmed.isEmpty
    }
}
