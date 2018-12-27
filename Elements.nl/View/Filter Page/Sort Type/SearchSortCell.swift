//
//  SearchSortCell.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchSortCell: UITableViewCell {
    @IBOutlet weak var sortTypeTitle: UILabel?
    private let sortTypes = SortType.allValues
    public var filter: SearchFilterViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        self.accessoryType = .none
        self.selectionStyle = .none
    }
    
    public func setupCell(at indexPath: IndexPath) {
        let title = sortTypes[indexPath.row]
        
        self.sortTypeTitle?.text = title
        self.accessoryType = (SortType(rawValue: indexPath.row)?.descriptions == filter.sort) ? .checkmark : .none
    }
}
