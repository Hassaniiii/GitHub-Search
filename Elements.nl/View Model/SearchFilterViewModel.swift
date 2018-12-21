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
            filter.keyword = "repositories?q=\(keyword)"
        }
        get {
            return filter.keyword
        }
    }
    var sort: String {
        set(newSort) {
            filter.sort = newSort
        }
        get {
            if let sortStr = filter.sort, !sortStr.isEmpty {
                return "&sort=" + sortStr
            }
            return ""
        }
    }
    
    override init() {
        super.init()
        
        self.filter = SearchFilterModel()
    }

    public func searchQuery() -> String {
        guard let keyword = self.keyword else { return "" }
        
        return keyword + self.sort
    }
}
