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
    private var displayItems: Array<SearchResultModelController> = []
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
        let itemSlice = items[startIndex..<endIndex]
        
        displayItems.append(contentsOf: itemSlice)
        completion(Array(itemSlice), nil)
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
    
    //MARK:- View data provider
    public func numberOfItems() -> Int {
        return displayItems.count
    }
    
    public func repoAvatar(at indexPath: IndexPath) -> URL? {
        if indexPath.row >= displayItems.count { return nil }
        return displayItems[indexPath.row].owner?.avatarURL
    }
    
    public func repoURL(at indexPath: IndexPath) -> URL? {
        if indexPath.row >= displayItems.count { return nil }
        return displayItems[indexPath.row].url
    }
    
    public func repoStars(at indexPath: IndexPath) -> String? {
        if indexPath.row >= displayItems.count { return nil }
        return displayItems[indexPath.row].starsCount?.stringValue
    }
    
    public func repoForks(at indexPath: IndexPath) -> String? {
        if indexPath.row >= displayItems.count { return nil }
        return displayItems[indexPath.row].forksCount?.stringValue
    }
    
    public func repoArchived(at indexPath: IndexPath) -> Bool {
        if indexPath.row >= displayItems.count { return true }
        return displayItems[indexPath.row].archived?.boolValue ?? true
    }
    
    public func repoName(at indexPath: IndexPath) -> String? {
        if indexPath.row >= displayItems.count { return nil }
        return displayItems[indexPath.row].name
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
