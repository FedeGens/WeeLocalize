//
//  LocalizeManager.swift
//  WeeLocalize
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import Foundation

typealias LocalizeSource = [String: [String:String]]

class WeeLocalizeManager {
    static let shared = WeeLocalizeManager()
    
    private var localizeSource: LocalizeSource = [:]
    private var localizeSettings: LocalizeSettings = LocalizeSettings(default_language: "", available_languages: [])
    
    var localizationFileName: String = "localize" {
        didSet {
            loadLocalizationFile(str: localizationFileName)
        }
    }
    
    var getStringHandler: (String, String?) -> String = { key, language in
        func processGetString(key: String, language: String?, oldLanguage oldLang: String? = nil) -> String {
            guard key != "" else { return "" }
            
            let lang = language ?? WeeLocalizeLanguageManager.shared.currentLanguage
            
            guard let source = WeeLocalizeManager.shared.localizeSource[key] else {
                print("[ WEELOCALIZE ⚠️ WARNING ] - No string found for key: \"\(key)\"")
                return key
            }
            
            guard let str = source[lang] else {
                if lang.contains("-") {
                    let correctedLang = lang.components(separatedBy: "-")[0]
                    return processGetString(key: key, language: correctedLang, oldLanguage: lang)
                }
                print("[ WEELOCALIZE ⚠️ WARNING ] - No string found for key: \"\(key)\" and language \"\(oldLang ?? lang)\"")
                guard language == WeeLocalizeManager.shared.localizeSettings.default_language ||
                    oldLang == WeeLocalizeManager.shared.localizeSettings.default_language else {
                        return processGetString(key: key, language: WeeLocalizeManager.shared.localizeSettings.default_language)
                }
                return key
            }
            
            return str
        }
        
        return processGetString(key: key, language: language)
    }
    
    init() {
        loadLocalizationFile(str: localizationFileName)
    }
    
    func loadLocalizationFile(str: String) {
        guard let path = Bundle.main.url(forResource: str, withExtension: "json"),
            let data = try? Data(contentsOf: path),
            let jsonContent = try? JSONDecoder().decode(LocalizeJSONContent.self, from: data) else {
                return
        }
        
        localizeSource = jsonContent.localize_strings
        localizeSettings = jsonContent.localize_settings
    }
    
    func getString(fromIdentifier key: String, language: String? = nil) -> String {
        return getStringHandler(key, language)
    }
}
