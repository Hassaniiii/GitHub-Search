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
    var url: String? { get set }
    var desc: String? { get set }
    var lastUpdate: String? { get set }
    var archived: NSNumber? { get set }
    var openIssuesCount: NSNumber? { get set }
    var starsCount: NSNumber? { get set }
}

class SearchResultModelController: SearchResultModel, Mappable {
    var id: NSNumber?
    var name: String?
    var privatee: NSNumber?
    var owner: SearchResultOwnerModelController?
    var url: String?
    var desc: String?
    internal var lastUpdate: String?
    var archived: NSNumber?
    var openIssuesCount: NSNumber?
    var starsCount: NSNumber?
    var update: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "GMT")
        
        guard let lastUpdate = self.lastUpdate else { return nil }
        guard let date = formatter.date(from: lastUpdate) else { return nil }
        return formatter.string(from: date)
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.privatee <- map["private"]
        self.owner <- map["owner"]
        self.url <- map["html_url"]
        self.desc <- map["description"]
        self.lastUpdate <- map["updated_at"]
        self.archived <- map["archived"]
        self.openIssuesCount <- map["open_issues_count"]
        self.starsCount <- map["stargazers_count"]
    }
}
