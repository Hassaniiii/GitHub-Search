//
//  SearchFilterTableView.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterTableView: UITableView {
    convenience init(frame: CGRect, dataSource: UITableViewDataSource) {
        self.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), style: .grouped)
        
        self.dataSource = dataSource
        self.initiateView()
    }
    
    private override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initiateView() {
        self.estimatedRowHeight = 80
        self.rowHeight = UITableView.automaticDimension
        self.allowsSelection = false
    }
}
