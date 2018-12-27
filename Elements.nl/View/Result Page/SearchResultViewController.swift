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
        self.initiateTable()
        self.loadData()
    }()
    private var page: Int = 1
    
    public class func instantiate() -> SearchResultViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "resultViewController") as? SearchResultViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.setNavigation(title: "Loading...")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _ = self.initiateView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.stopSearchSession()
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
            self.switchToNoMoreData(items?.count == 0 || items == nil)
            self.table.reloadData()
        }
    }
    
    private func showLoading() {
        super.setNavigation(title: "Loading...")
        Loading.show(title: "Please wait", message: "fetching data...", on: self.table)
    }
    
    private func hideLoading() {
        super.setNavigation(title: "Showing \(viewModel.numberOfItems()) of \(viewModel.numberOfAllItems())")
        Loading.hide()
    }
    
    private func initiateTable() {
        guard let tableFrame = self.containerView?.frame else { return }
        self.table = SearchResultTableView(frame: tableFrame, dataSource: self.dataSource, delegate: self.dataSource)
        self.table.footerDelegate = self
        self.containerView?.addSubview(table)
    }
}

extension SearchResultViewController {
    fileprivate func switchToNoMoreData(_ noMoreData: Bool) {
        self.table.switchRefreshFooter(to: (noMoreData) ? .noMoreData : .normal)
    }
}

extension SearchResultViewController: SearchResultTableDelegate {
    func tableDidReachedAtTheBottom() {
        self.page += 1
        self.loadData()
    }
}
