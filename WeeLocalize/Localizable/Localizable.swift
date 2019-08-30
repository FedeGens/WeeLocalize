//
//  Translatable.swift
//  WeeTranslate
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import Foundation

protocol Localizable {
    func reload()
    func setString(fromIdentifier: String, language: String?)
    
    var localizableIdentifier: String { get set }
}
