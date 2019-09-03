//
//  LocalizableLabel.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import UIKit

open class LocalizableLabel: UILabel, Localizable {    
    //MARK: Localizable Protocol
    @IBInspectable var localizableIdentifier: String = "" {
        didSet { reload() }
    }
    
    func reload() {
        setString(fromIdentifier: localizableIdentifier)
    }
    
    func setString(fromIdentifier key: String, language: String? = nil) {
        guard localizableIdentifier != "" else {
            return
        }
        self.text = WeeLocalizeManager.shared.getString(fromIdentifier: key, language: language)
    }
}

