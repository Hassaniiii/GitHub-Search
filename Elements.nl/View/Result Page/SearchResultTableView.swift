//
//  SearchResultTableView.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchResultTableView: BaseTableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        self.register(UINib(nibName: "SearchResultItemCell", bundle: nil), forCellReuseIdentifier: "result_cell")
        self.backgroundColor = .groupTableViewBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
