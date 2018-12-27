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
    private var allItemsCount: NSNumber = 0
    private var items: [SearchResultModelController] = []
    private var displayItems: Array<SearchResultModelController> = []
    private var pageSize: Int = 10
    private var pageCounter: Int = 0
    private var serviceManager: ServiceManager!
    
    override init() {
        super.init()
        
        self.serviceManager = ServiceManager()
    }
    
    public func getSearchResult(using filter: SearchFilterViewModel, at page: Int, on completion: @escaping resultCompletion) {
        self.pageCounter = page
        isCachedResponse() ? getCachedResponse(completion) : sendSearchRequest(filter, completion)
    }
    
    private func getCachedResponse(_ completion: @escaping resultCompletion) {
        let startIndex = pageCounter * pageSize
        let endIndex = isEnough() ? (pageCounter + 1) * pageSize : items.count
        if endIndex < startIndex { completion([], nil); return }
        
        let itemSlice = items[startIndex..<endIndex]
        displayItems.append(contentsOf: itemSlice)
        completion(Array(itemSlice), nil)
    }
    
    private func sendSearchRequest(_ filter: SearchFilterViewModel, _ completion: @escaping resultCompletion) {
        let router = SearchResultRouter.fetch(query: filter.searchQuery())
        self.serviceManager.APICall(router) { (response, error) in
            if let error = error {
                completion(nil, error);
                return;
            }
            
            if let response = response, let result = Mapper<SearchResultBaseModelController>().map(JSON: response) {
                self.allItemsCount = result.total ?? 0
                self.items.append(contentsOf: result.items ?? [])
                self.getCachedResponse(completion)
                return
            }
            completion([], nil)
        }

    }
    
    //MARK:- View data provider
    public func numberOfAllItems() -> Int {
        return self.allItemsCount.intValue
    }
    
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
        return items.count != displayItems.count
    }
    
    fileprivate func isEnough() -> Bool {
        return items.count > (pageSize) * (pageCounter + 1)
    }
}
