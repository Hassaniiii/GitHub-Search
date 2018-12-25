//
//  SearchResultOwnerModel.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//
import ObjectMapper

protocol SearchResultOwnerModel {
    var id: NSNumber? { get set }
    var avatarURL: String? { get set }
    var profileURL: String? { get set }
}

class SearchResultOwnerModelController: SearchResultOwnerModel, Mappable {
    var id: NSNumber?
    internal var avatarURL: String?
    internal var profileURL: String?
    var avatar: URL? {
        guard let avatarURL = avatarURL else { return nil }
        return URL(string: avatarURL)
    }
    var url: URL? {
        guard let profileURL = profileURL else { return nil }
        return URL(string: profileURL)
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.avatarURL <- map["avatar_url"]
        self.profileURL <- map["html_url"]
    }
}
