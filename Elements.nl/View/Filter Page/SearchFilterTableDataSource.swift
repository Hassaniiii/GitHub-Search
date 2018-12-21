//
//  SearchFilterTableDataSource.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchFilterTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var header: [String] {
        return ["Keyword"]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { return header.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "keyword_cell", for: indexPath) as? SearchKeywordCell {
           
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
}
