//
//  LocalizableStructs.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 03/09/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import Foundation

struct LocalizeSettings: Codable {
    var default_language: String
    var available_languages: [LocalizeAvailableLanguage]
}

struct LocalizeAvailableLanguage: Codable {
    var key: String
    var value: String
}

struct LocalizeJSONContent: Codable {
    let localize_settings: LocalizeSettings
    let localize_strings: LocalizeSource
}
