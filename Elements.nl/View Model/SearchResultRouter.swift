//
//  SearchResultRouter.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/24/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Alamofire

enum SearchResultRouter  {
    case fetch(query: String)
}

extension SearchResultRouter: ServiceAPIRouter {
    var method: HTTPMethod? {
        switch self {
            case .fetch:
                return .get
        }
    }
    
    var path: String {
        switch self {
            case .fetch(let query):
                return query
        }
    }
    
    var params: Parameters? {
        switch self {
            case .fetch:
                return [:]
        }
    }
}
