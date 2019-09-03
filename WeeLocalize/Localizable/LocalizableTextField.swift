//
//  LocalizableTextField.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 03/09/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import UIKit

open class LocalizableTextField: UITextField, Localizable {
    //MARK: Localizable Protocol
    @IBInspectable var localizableIdentifier: String = "" {
        didSet { reload() }
    }
    
    func reload() {
        setString(fromIdentifier: localizableIdentifier)
    }
    
    func setString(fromIdentifier key: String, language: String? = nil) {
        self.placeholder = WeeLocalizeManager.shared.getString(fromIdentifier: key, language: language)
    }
}
