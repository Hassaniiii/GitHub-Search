//
//  SearchFilterTableView.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    required convenience init(frame: CGRect, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), style: .grouped)
        
        self.dataSource = dataSource
        self.delegate = delegate
        self.initiateTable()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initiateTable() {
        self.estimatedRowHeight = 80
        self.rowHeight = UITableView.automaticDimension
        self.tableFooterView = UIView()
    }
}
