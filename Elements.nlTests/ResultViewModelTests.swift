//
//  ResultViewModelTests.swift
//  Elements.nlTests
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Elements_nl

class ResultViewModelTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }
}

extension ResultViewModelTests {
    fileprivate var stubsURL: OHHTTPStubsTestBlock {
        return isHost("api.github.com")
    }
    
    fileprivate func APICall() {
        stub(condition: stubsURL) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("github_search_result.json", type(of: self))!,
                statusCode: 200,
                headers: ["Accept": "application/vnd.github.mercy-preview+json",
                          "User-Agent": "hassaniiii"]
            )
        }

    }
}
