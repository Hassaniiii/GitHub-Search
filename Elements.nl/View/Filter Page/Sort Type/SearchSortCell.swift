//
//  SearchSortCell.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchSortCell: UITableViewCell {
    @IBOutlet weak var sortTypeSegment: UISegmentedControl?
    public var filter: SearchFilterViewModel!
    
    @IBAction func sortTypeChanged(_ sender: UISegmentedControl) {
        self.sortTypeSelected()
    }
    
    private func sortTypeSelected() {
        let selectedIndex = sortTypeSegment?.selectedSegmentIndex ?? 0
        guard let sort = SortType(rawValue: selectedIndex) else { return }
        filter.sort = sort.descriptions
    }
}
