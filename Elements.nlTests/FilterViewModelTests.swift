//
//  FilterViewModelTests.swift
//  Elements.nlTests
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import Elements_nl

class FilterViewModelTests: XCTestCase {
    private var search_filter: SearchFilterViewModel!
    
    override func setUp() {
        search_filter = SearchFilterViewModel()
    }

    override func tearDown() { }

    func test_searchFilter_nil() {
        let query = search_filter.searchQuery()
        XCTAssertEqual(query, "")
    }
    
    func test_searchFilter_basicQuery() {
        search_filter.keyword = "CBORSwift"
        
        let query = search_filter.searchQuery()
        XCTAssertEqual(query, "repositories?q=CBORSwift")
    }
    
    func test_searchFilter_withSort() {
        search_filter.keyword = "CBORSwift"
        search_filter.sort = ""
        
        let query = search_filter.searchQuery()
        XCTAssertEqual(query, "repositories?q=CBORSwift")
    }
}
