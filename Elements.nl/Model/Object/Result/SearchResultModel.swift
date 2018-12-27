//
//  SearchResultModel.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//


import ObjectMapper

protocol SearchResultModel {
    var id: NSNumber? { get set }
    var name: String? { get set }
    var privatee: NSNumber? { get set }
    var owner: SearchResultOwnerModelController? { get set }
    var url: URL? { get set }
    var desc: String? { get set }
    var archived: NSNumber? { get set }
    var openIssuesCount: NSNumber? { get set }
    var starsCount: NSNumber? { get set }
    var forksCount: NSNumber? { get set }
}

class SearchResultModelController: SearchResultModel, Mappable {
    var id: NSNumber?
    var name: String?
    var privatee: NSNumber?
    var owner: SearchResultOwnerModelController?
    var url: URL?
    var desc: String?
    var archived: NSNumber?
    var openIssuesCount: NSNumber?
    var starsCount: NSNumber?
    var forksCount: NSNumber?
    var update: String? {
        set {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter.timeZone = TimeZone(identifier: "GMT")
            
            guard let dateStr = newValue else { return }
            _update = formatter.date(from: dateStr)
        }
        get {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            formatter.timeZone = TimeZone(identifier: "GMT")
            
            guard let date = _update else { return "" }
            return formatter.string(from: date)
        }
    }
    private let formatter = DateFormatter()
    private var _update: Date?
    private var _url: String? {
        set {
            guard let url = newValue else { return }
            self.url = URL(string: url)
        }
        get {
            return self.url?.absoluteString
        }
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["full_name"]
        self.privatee <- map["private"]
        self.owner <- map["owner"]
        self._url <- map["html_url"]
        self.desc <- map["description"]
        self.update <- map["updated_at"]
        self.archived <- map["archived"]
        self.openIssuesCount <- map["open_issues_count"]
        self.starsCount <- map["stargazers_count"]
        self.forksCount <- map["forks_count"]
    }
}
