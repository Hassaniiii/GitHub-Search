//
//  SearchFilterViewController.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView?
    private var viewModel: SearchFilterViewModel!
    private var table: SearchFilterTableView!
    private var dataSource: SearchFilterTableDataSource!
    private lazy var initiateView: Void = {
        self.initiateVariable()
        self.addFilterTable()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.setNavigation(title: "Search Filters")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = self.initiateView
    }
    
    private func initiateVariable() {
        guard let tableFrame = self.containerView?.frame else { return }
        self.dataSource = SearchFilterTableDataSource()
        self.table = SearchFilterTableView(frame: tableFrame, dataSource: self.dataSource)
    }
    
    private func addFilterTable() {
        self.containerView?.addSubview(table)
        self.table.reloadData()
    }
}
