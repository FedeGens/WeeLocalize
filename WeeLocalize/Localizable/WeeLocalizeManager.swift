//
//  LocalizeManager.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import Foundation

class WeeLocalizeManager {
    typealias LocalizeSource = [String: [String:String]]
    
    static let shared = WeeLocalizeManager()
    
    private var localizeSource: LocalizeSource = [:]
    private var oldLang: String? = nil
    
    var localizationFileName: String = "localize" {
        didSet {
            loadLocalizationFile(str: localizationFileName)
        }
    }
    
    var getStringHandler: (String, String?) -> String = { key, language in
        guard key != "" else {
            return ""
        }
        
        let lang = language ?? WeeLocalizeLanguageManager.shared.currentLanguage
        
        guard let source = WeeLocalizeManager.shared.localizeSource[key] else {
            print("[ WEELOCALIZE ⚠️ WARNING ] - No string found for key: \"\(key)\"")
            return key
        }
        
        guard let str = source[lang] else {
            if lang.contains("-") {
                WeeLocalizeManager.shared.oldLang = lang
                let correctedLang = lang.components(separatedBy: "-")[0]
                return WeeLocalizeManager.shared.getString(fromIdentifier: key, language: correctedLang)
            }
            print("[ WEELOCALIZE ⚠️ WARNING ] - No string found for key: \"\(key)\" and language \"\(WeeLocalizeManager.shared.oldLang ?? lang)\"")
            WeeLocalizeManager.shared.oldLang = nil
            guard language == "default" else {
                return WeeLocalizeManager.shared.getString(fromIdentifier: key, language: "default")
            }
            return key
        }
        
        WeeLocalizeManager.shared.oldLang = nil
        
        return str
    }
    
    init() {
        loadLocalizationFile(str: localizationFileName)
    }
    
    func loadLocalizationFile(str: String) {
        guard let path = Bundle.main.url(forResource: str, withExtension: "json"),
            let data = try? Data(contentsOf: path),
            let object = try? JSONSerialization.jsonObject(with: data, options: []) as? LocalizeSource else {
                return
        }
        
        localizeSource = object
    }
    
    func getString(fromIdentifier key: String, language: String? = nil) -> String {
        return getStringHandler(key, language)
    }
}
