//
//  BaseViewController.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/21/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    internal func setNavigation(title: String) {
        let navigationAttribute: [NSAttributedString.Key:Any] = [.font: UIFont.boldSystemFont(ofSize: 15.0),
                                                                 .foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = navigationAttribute
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = title
    }
}
