//
//  SearchResultViewModel.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Foundation
import ObjectMapper

typealias resultCompletion = ((_ items: [SearchResultModelController]?, _ error: Error?) -> Void)

class SearchResultViewModel: NSObject {
    private var items: [SearchResultModelController] = []
    private var pageSize: Int = 10
    private var serviceManager: ServiceManager!
    
    override init() {
        super.init()
        
        self.serviceManager = ServiceManager()
    }
    
    public func getSearchResult(using filter: SearchFilterViewModel, at page: Int, on completion: @escaping resultCompletion) {
        isCachedResponse() ? getCachedResponse(page, completion) : sendSearchRequest(filter, completion)
    }
    
    private func getCachedResponse(_ page: Int, _ completion: @escaping resultCompletion) {
        let startIndex = page * pageSize
        let endIndex = isEnough(page) ? (page + 1) * pageSize : items.count
        
        completion(Array(items[startIndex..<endIndex]), nil)
    }
    
    private func sendSearchRequest(_ filter: SearchFilterViewModel, _ completion: @escaping resultCompletion) {
        let router = SearchResultRouter.fetch(query: filter.searchQuery())
        self.serviceManager.APICall(router) { (response, error) in
            self.items = []
            if let error = error {
                completion(nil, error);
                return;
            }
            
            if let response = response, let result = Mapper<SearchResultBaseModelController>().map(JSON: response) {
                self.items = result.items ?? []
                self.getCachedResponse(0, completion)
                return
            }
            completion([], nil)
        }

    }
}

extension SearchResultViewModel {
    fileprivate func isCachedResponse() -> Bool {
        return items.count != 0
    }
    
    fileprivate func isEnough(_ currentPage: Int) -> Bool {
        return items.count > (pageSize) * (currentPage + 1)
    }
}
