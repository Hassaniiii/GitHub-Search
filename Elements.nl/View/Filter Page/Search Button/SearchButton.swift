//
//  SearchButton.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class SearchButton: UIButton {
    public var enable: Bool! {
        didSet {
            (enable) ? enableBtn() : disableBtn()
            self.isEnabled = enable
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shape()
    }
    
    private func shape() {
        self.disableBtn()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
    }
    
    private func enableBtn() {
        self.backgroundColor = UIColor.black
        self.tintColor = UIColor.white
    }
    
    private func disableBtn() {
        self.backgroundColor = UIColor.lightGray
        self.tintColor = UIColor.white
    }
}
