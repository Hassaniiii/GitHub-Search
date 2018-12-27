//
//  SearchFilterTableView.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterTableView: BaseTableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.registerCells()
        self.initiateTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func registerCells() {
        self.register(UINib(nibName: "SearchKeywordCell", bundle: nil), forCellReuseIdentifier: "keyword_cell")
        self.register(UINib(nibName: "SearchSortCell", bundle: nil), forCellReuseIdentifier: "sortType_cell")
    }
    
     private func initiateTable() {
        self.separatorStyle = .singleLine
        self.separatorColor = Theme.backgroundColor
        self.allowsSelection = true
    }
}
