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
    private var searchResultViewModel: SearchResultViewModel!
    
    override func setUp() {
        searchResultViewModel = SearchResultViewModel()
    }

    override func tearDown() { }
    
    func test_searchResult_Success_CompleteResponse() {
        let exp_success = self.expectation(description: "search result complete response")
        self.APICall_Success_CompleteResponse()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertGreaterThanOrEqual(items?.count ?? 0, 0)
            
            exp_success.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_searchResult_Success_CompleteResponse_ParseResponse() {
        let exp_success = self.expectation(description: "search result complete response")
        self.APICall_Success_CompleteResponse()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertNotNil(items?.first)
            
            guard let item = items?.first else { return }
            XCTAssertEqual(item.id?.intValue, 132188242)
            XCTAssertEqual(item.name, "CBORSwift")
            XCTAssertFalse(item.privatee?.boolValue ?? true)
            XCTAssertEqual(item.url, "https://github.com/Hassaniiii/CBORSwift")
            XCTAssertEqual(item.desc, "Swift implementation for CBOR")
            XCTAssertEqual(item.update, "2018-12-24 19:11")
            XCTAssertFalse(item.archived?.boolValue ?? true)
            XCTAssertEqual(item.openIssuesCount?.intValue, 1)
            XCTAssertEqual(item.starsCount?.intValue, 1)
            XCTAssertNotNil(item.owner)
            
            guard let owner = item.owner else { return }
            XCTAssertEqual(owner.id?.intValue, 11143939)
            XCTAssertEqual(owner.avatarURL, URL(string: "https://avatars2.githubusercontent.com/u/11143939?v=4"))
            XCTAssertEqual(owner.profileURL, URL(string: "https://github.com/Hassaniiii"))
            
            exp_success.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)

    }
    
    func test_searchResult_Success_EmptyResponse() {
        let exp_success = self.expectation(description: "search result empty response")
        self.APICall_Success_EmptyResponse()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items?.count ?? 1, 0)
            
            exp_success.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_searchResult_Success_NilResponse() {
        let exp_success = self.expectation(description: "search result nil response")
        self.APICall_Success_NilResponse()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items?.count ?? 1, 0)
            
            exp_success.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_searchResult_Failure() {
        let exp_failure = self.expectation(description: "search result nil response")
        self.APICall_Failure()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(items)
            
            exp_failure.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_searchResult_CachingMechanismt() {
        let exp_success = self.expectation(description: "search result with huge complete respo")
        self.APICall_HugeResponse()
        
        searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 0) { (items, error) in
            XCTAssertEqual(items?.count ?? 0, 10)
            XCTAssertNotNil(items?.first)
            
            guard let firstItem = items?.first else { return }
            XCTAssertEqual(firstItem.id?.intValue, 44838949)
            
            self.searchResultViewModel.getSearchResult(using: self.mockFilterViewModel(), at: 1) { (items, error) in
                XCTAssertEqual(items?.count ?? 0, 10)
                XCTAssertNotNil(items?.first)
                
                guard let firstItem = items?.first else { return }
                XCTAssertEqual(firstItem.id?.intValue, 20822291)
                
                exp_success.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}

extension ResultViewModelTests {
    //MARK:- Service stubs
    fileprivate var stubsURL: OHHTTPStubsTestBlock {
        return isHost("api.github.com")
    }
    
    fileprivate func APICall_Success_CompleteResponse() {
        stub(condition: stubsURL) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("github_search_result.json", type(of: self))!,
                statusCode: 200,
                headers: ["Accept": "application/vnd.github.mercy-preview+json",
                          "User-Agent": "hassaniiii"]
            )
        }
    }
    
    fileprivate func APICall_Success_EmptyResponse() {
        stub(condition: stubsURL) { _ in
            let response: [String:Any] = ["total": 0, "incomplete": true, "items": []]
            return OHHTTPStubsResponse(jsonObject: response, statusCode: 200, headers: nil)
        }
    }
    
    fileprivate func APICall_Success_NilResponse() {
        stub(condition: stubsURL) { _ in
            let response: [String:Any?] = ["total": 0, "incomplete": true, "items": nil]
            return OHHTTPStubsResponse(jsonObject: response, statusCode: 200, headers: nil)
        }
    }
    
    fileprivate func APICall_Failure() {
        stub(condition: stubsURL) { _ in
            return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: nil)
        }
    }
    
    fileprivate func APICall_HugeResponse() {
        stub(condition: stubsURL) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("github_huge_search_result.json", type(of: self))!,
                statusCode: 200,
                headers: ["Accept": "application/vnd.github.mercy-preview+json",
                          "User-Agent": "hassaniiii"]
            )
        }
    }
    
    //MARK:- Service mock
    fileprivate func mockFilterViewModel() -> SearchFilterViewModel {
        let searchFilterViewModel = SearchFilterViewModel()
        searchFilterViewModel.keyword = "CBORSwift"
        
        return searchFilterViewModel
    }
}
