//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/21/23.
//

import XCTest
import SwiftUI

@testable import DNYK_Core

class ColorExtensionTests: XCTestCase {
    func testColorFromHex() {
        let color = Color.fromHex("00FF00")
        XCTAssertEqual(color, Color(red: 0, green: 1, blue: 0))
    }
}
