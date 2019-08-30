//
//  UIView+WeeLocalize.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import UIKit

extension UIView {
    func reloadLocalization() {
        if let localizable = self as? Localizable {
            localizable.reload()
        }
        
        for child in self.subviews {
            child.reloadLocalization()
        }
    }
}
