//
//  Shape.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/27/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import UIKit

class Shape: NSObject {
    class func round(_ view: UIView) -> UIView {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        
        return view
    }
}
