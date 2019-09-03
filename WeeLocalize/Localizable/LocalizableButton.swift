//
//  LocalizableButton.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import UIKit

open class LocalizableButton: UIButton, Localizable {
    //MARK: Localizable Protocol
    @IBInspectable var localizableIdentifier: String = "" {
        didSet { reload() }
    }
    
    func reload() {
        setString(fromIdentifier: localizableIdentifier)
    }
    
    func setString(fromIdentifier: String, language: String? = nil) {
        guard localizableIdentifier != "" else {
            return
        }
        self.setTitle(WeeLocalizeManager.shared.getString(fromIdentifier: localizableIdentifier, language: language), for: .normal)
        
    }
}

