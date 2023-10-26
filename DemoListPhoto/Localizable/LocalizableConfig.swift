//
//  LocalizableConfig.swift
//  DemoListPhoto
//
//  Created by Tin/Perry/ServiceDev on 26/10/2023.
//

import Foundation



extension String {
    var localized: String {
         let currentLanguage = Bundle.main.preferredLocalizations.first
        guard let bundlePath = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath)
        else {
            print("No BundlePath")
            return self
        }
        
        return bundle.localizedString(forKey: self, value: nil, table: nil)
        
    }
}










