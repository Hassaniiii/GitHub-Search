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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
        self.accessoryType = .none
        self.selectionStyle = .none
    }
    
    public func setupCell(_ title: String) {
        self.sortTypeTitle?.text = title
    }
}
