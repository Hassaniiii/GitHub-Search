//
//  SearchResultTableDataSource.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchResultTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    public var resultViewModel: SearchResultViewModel!
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultViewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as? SearchResultItemCell {
            
            cell.setupCell(resultViewModel, at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
