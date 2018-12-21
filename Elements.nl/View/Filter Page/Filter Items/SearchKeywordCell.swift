//
//  SearchKeywordCell.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchKeywordCell: UITableViewCell {
    @IBOutlet weak var keyword: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        keyword?.returnKeyType = .done
    }
}

extension SearchKeywordCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
