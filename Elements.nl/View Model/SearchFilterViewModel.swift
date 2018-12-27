//
//  SearchFilterViewModel.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterViewModel: NSObject {
    var filter: SearchFilterModel!
    var keyword: String? {
        set(newKeyword) {
            guard let keyword = newKeyword else { return }
            guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
            filter.keyword = "repositories?q=\(encodedKeyword)"
        }
        get {
            return filter.keyword?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    var sort: String {
        set(newSort) {
            filter.sort = newSort
        }
        get {
            if let sortStr = filter.sort, !sortStr.isEmpty {
                return "&sort=" + sortStr.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            return ""
        }
    }
    private var pageCounter: Int = 1
    
    override init() {
        super.init()
        
        self.filter = SearchFilterModel()
    }

    public func searchQuery() -> String {
        guard let keyword = self.keyword else { return "" }
        
        return self.searchQueryWithPaging(keyword + self.sort)
    }
    
    public func resetPaging() {
        self.pageCounter = 1
    }
    
    private func searchQueryWithPaging(_ currentQuery: String) -> String {
        if currentQuery == "" { return "" }
        let pagingQuery = "\(currentQuery)&perpage=30&page=\(pageCounter)"
        pageCounter += 1
        
        return pagingQuery
    }
}
