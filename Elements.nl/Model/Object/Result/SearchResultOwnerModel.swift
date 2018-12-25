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
    var avatarURL: URL? { get set }
    var profileURL: URL? { get set }
}

class SearchResultOwnerModelController: SearchResultOwnerModel, Mappable {
    var id: NSNumber?
    var avatarURL: URL?
    var profileURL: URL?
    private var _avatarURL: String? {
        set {
            guard let url = newValue else { return }
            avatarURL = URL(string: url)
        }
        get {
            return avatarURL?.absoluteString
        }
    }
    private var _profileURL: String? {
        set {
            guard let url = newValue else { return }
            profileURL = URL(string: url)
        }
        get {
            return profileURL?.absoluteString
        }
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self._avatarURL <- map["avatar_url"]
        self._profileURL <- map["html_url"]
    }
}
