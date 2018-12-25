//
//  SearchResultTableViewCell.swift
//  Elements.nl
//
//  Created by Hassan Shahbazi on 12/25/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchResultItemCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shapeView()
    }

    private func shapeView() {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
    }
}
