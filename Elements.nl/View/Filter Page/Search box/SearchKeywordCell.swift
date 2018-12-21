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
    public var bindedBtn: SearchButton?
    public var filter: SearchFilterViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        keyword?.returnKeyType = .done
    }
}

extension SearchKeywordCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.bindedBtn?.enable = !(textField.text?.isEmpty ?? true)
        self.filter.keyword = textField.text
    
        textField.resignFirstResponder()
        return true
    }
}
