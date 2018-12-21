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
    @IBOutlet weak var searchBtn: SearchButton?
    
    private var filter: SearchFilterViewModel!
    private var table: SearchFilterTableView!
    private var dataSource: SearchFilterTableDataSource!
    private lazy var initiateView: Void = {
        self.initiateVariable()
        self.initiateTable()
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
        self.filter = SearchFilterViewModel()
        self.dataSource = SearchFilterTableDataSource()
        self.dataSource.filter = filter
        self.dataSource.bindedBtn = searchBtn
    }
    
    private func initiateTable() {
        guard let tableFrame = self.containerView?.frame else { return }
        self.table = SearchFilterTableView(frame: tableFrame, dataSource: self.dataSource)
    }
    
    private func addFilterTable() {
        self.containerView?.addSubview(table)
        self.table.reloadData()
    }
    
    @IBAction func search(_ sender: UIButton) {
        print(filter.searchQuery())
    }
}
