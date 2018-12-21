//
//  SearchFilterInterface.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Foundation

protocol SearchFilterInterface {
    var keyword: String? { get set }
    var sort: String? { get set }
}

enum SortType: String {
    case defaults   = ""
    case stars      = "stars"
    case forks      = "forks"
    case updated    = "updated"
}
