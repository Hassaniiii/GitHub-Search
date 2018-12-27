//
//  SearchResultViewController.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit
import PKHUD

class SearchResultViewController: BaseViewController {
    @IBOutlet weak var containerView: UIView?

    public var filter = SearchFilterViewModel()
    private var table: SearchResultTableView!
    private var dataSource: SearchResultTableDataSource!
    private var viewModel: SearchResultViewModel!
    private lazy var initiateView: Void = {
        self.initiateVariable()
        self.loadData()
    }()
    private var page: Int = 0
    
    public class func instantiate() -> SearchResultViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "resultViewController") as? SearchResultViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.setNavigation(title: "Search Result")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = self.initiateView
    }

    private func initiateVariable() {
        self.viewModel = SearchResultViewModel()
        self.dataSource = SearchResultTableDataSource()
        self.dataSource.resultViewModel = self.viewModel
    }
    
    private func loadData() {
        self.showLoading()
        viewModel.getSearchResult(using: filter, at: page) { (items, error) in
            self.hideLoading()
            self.initiateTable()
            self.addResultTable()
        }
    }
    
    private func showLoading() {
        Loading.show(title: "Please wait", message: "fetching data from GitHub...", on: self.containerView)
    }
    
    private func hideLoading() {
        Loading.hide()
    }
    
    private func initiateTable() {
        guard let tableFrame = self.containerView?.frame else { return }
        self.table = SearchResultTableView(frame: tableFrame, dataSource: self.dataSource, delegate: self.dataSource)
    }
    
    private func addResultTable() {
        self.containerView?.addSubview(table)
        self.table.reloadData()
    }
}
