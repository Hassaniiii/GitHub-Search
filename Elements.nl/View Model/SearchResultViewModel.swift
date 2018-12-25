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
    private var serviceManager: ServiceManager!
    
    override init() {
        super.init()
        
        self.serviceManager = ServiceManager()
    }
    
    public func getSearchResult(using filter: SearchFilterViewModel, on completion: @escaping resultCompletion) {
        let router = SearchResultRouter.fetch(query: filter.searchQuery())        
        self.serviceManager.APICall(router) { (response, error) in
            if let error = error {
                completion(nil, error);
                return;
            }
            
            if let response = response, let result = Mapper<SearchResultBaseModelController>().map(JSON: response) {
                completion(result.items ?? [], nil)
                return
            }
            completion([], nil)
        }
    }
}
