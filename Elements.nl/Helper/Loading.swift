//
//  HUD.swift
//  Elements.nl
//
//  Created by Hassaniiii on 12/27/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import PKHUD

class Loading: NSObject {
    class func show(title: String, message: String, on view: UIView?, completion: ((Bool) -> Void)? = nil) {
        DispatchQueue.main.async {
            HUD.flash(.labeledProgress(title: title, subtitle: message), onView:view, delay: 60.0) { (finished) in
                self.hide()
                completion?(finished)
            }
        }
    }
    
    class func hide() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
}
