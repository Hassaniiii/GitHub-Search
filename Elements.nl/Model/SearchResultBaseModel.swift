//
//  SearchResultBaseModel.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import ObjectMapper

protocol SearchResultBaseModel {
    var total: NSNumber? { get set }
    var incomplete: NSNumber? { get set }
    var items: [SearchResultModelController]? { get set}
}

class SearchResultBaseModelController: SearchResultBaseModel, Mappable {
    var total: NSNumber?
    var incomplete: NSNumber?
    var items: [SearchResultModelController]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self.total <- map["total_count"]
        self.incomplete <- map["incomplete_results"]
        self.items <- map["items"]
    }
    
    
}
