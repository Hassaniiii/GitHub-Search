//
//  SearchResultTableView.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit
import PullToRefreshKit

protocol SearchResultTableDelegate {
    func tableDidReachedAtTheBottom()
}

class SearchResultTableView: BaseTableView {
    public var footerDelegate: SearchResultTableDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        self.register(UINib(nibName: "SearchResultItemCell", bundle: nil), forCellReuseIdentifier: "result_cell")
        
        self.backgroundColor = .groupTableViewBackground
        self.initiateFooter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initiateFooter() {
        self.configRefreshFooter(with: TableConfig.footerConfig(), container: self) { [weak self] in
            if let bottomCheck = self?.reachedAtTheBottom(), bottomCheck {
                self?.footerDelegate?.tableDidReachedAtTheBottom()
            }
        }
        self.footerAlwaysAtBottom = false
    }
    
    private func reachedAtTheBottom() -> Bool {
        let height = self.frame.height
        let contentYoffset = self.contentOffset.y
        let distanceFromBottom = self.contentSize.height - contentYoffset;
        
        return distanceFromBottom < height
    }
}
