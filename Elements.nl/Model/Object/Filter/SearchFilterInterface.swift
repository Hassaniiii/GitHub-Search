//
//  SearchFilterInterface.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

protocol SearchFilterInterface {
    var keyword: String? { get set }
    var sort: String? { get set }
}

enum SortType: Int {
    case defaults   = 0
    case forks      = 1
    case stars      = 2
    case updated    = 3
    
    var descriptions: String {
        switch self {
            case .defaults:
                return ""
            case .forks:
                return "forks"
            case .stars:
                return "stars"
            case .updated:
                return "updated"
        }
    }

    static let allValues = ["default", "forks", "stars", "updated"]
}
