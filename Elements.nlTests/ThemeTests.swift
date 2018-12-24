//
//  ThemeTests.swift
//  Elements.nlTests
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Elements_nl

class ThemeTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }
    
    func test_themeBackgroundColors() {
        XCTAssertEqual(UIColor.black, Theme.backgroundColor)
    }
    
    func test_themeDisabledColors() {
        XCTAssertEqual(UIColor.gray, Theme.disabledColor)
    }
    
    func test_themeFontColors() {
        XCTAssertEqual(UIColor.white, Theme.fontColor)
    }
}
