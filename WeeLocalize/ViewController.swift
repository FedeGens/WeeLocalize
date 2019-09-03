//
//  ViewController.swift
//  WeeTranslate
//
//  Created by Federico Gentile on 29/04/2019.
//  Copyright © 2019 gens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func changePressed(_ sender: Any) {
        WeeLocalizeLanguageManager.shared.set(currentLanguage: WeeLocalizeLanguageManager.shared.currentLanguage == "it" ? "asdasfsada" : "it")
                
        self.reloadLocalization()
    }
}

