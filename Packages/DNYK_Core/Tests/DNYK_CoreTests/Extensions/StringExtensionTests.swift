//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/21/23.
//

import XCTest

@testable import DNYK_Core

class StringExtensionTests: XCTestCase {
    func testTrimmed() {
        let string = "  Hello World  "
        XCTAssertEqual(string.trimmed, "Hello World")
    }
    
    func testNullIfEmpty() {
        let string = "       "
        XCTAssertNil(string.nullIfEmpty)
        
        let string2 = "Hello World"
        XCTAssertEqual(string2.nullIfEmpty, "Hello World")
    }
    
    func testIsEmptyAfterTrimming() {
        let string = "       "
        XCTAssertTrue(string.isEmptyAfterTrimming)
        
        let string2 = "Hello World"
        XCTAssertFalse(string2.isEmptyAfterTrimming)
    }
}

