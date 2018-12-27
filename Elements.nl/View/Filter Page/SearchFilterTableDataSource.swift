//
//  SearchFilterTableDataSource.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    public var filter: SearchFilterViewModel!
    public var bindedBtn: SearchButton!
    private var header: [String] {
        return ["Keyword", "Sort"]
    }
    private var rows: [Int] {
        return [1, 4]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return header.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return rows[section] }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "keyword_cell", for: indexPath) as? SearchKeywordCell {
           
            cell.filter = self.filter
            cell.bindedBtn = self.bindedBtn
            return cell
        }
        if indexPath.section == 1, let cell = tableView.dequeueReusableCell(withIdentifier: "sortType_cell", for: indexPath) as? SearchSortCell {
            
            cell.filter = self.filter
            cell.setupCell(at: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44.0 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.visibleCells.forEach({ $0.accessoryType = .none })
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            filter.sort = SortType(rawValue: indexPath.row)?.descriptions ?? ""
        }
    }
}
