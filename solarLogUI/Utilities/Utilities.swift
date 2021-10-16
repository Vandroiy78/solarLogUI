//
//  Utilities.swift
//  solarLogUI
//
//  Created by Holger Preu on 07.07.21.
//

import Foundation

class Utilities {
    
    static func getDatePartAsString(_ format:String) -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        // formatter.locale = Locale(identifier: "de_CH")
        
        return formatter.string(from: now)
    }
    
    static func saveSettings(value:String, key:String) {
        
        // Get a reference to the user defaults
        let defaults = UserDefaults.standard
        
        // Save the settings
        defaults.set(value, forKey: key)
    }
    
    static func retrieveSettings(key:String) -> Any? {
        
        // Get a reference to the user defaults
        let defaults = UserDefaults.standard
        
        return defaults.value(forKey: key)
    }
    
    // converts a number to 'kilo' or 'mega' if applicable and displays it with the according unit (with k or M as prefix)
    static func prettyPrint(_ number:Int, _ unit:String) -> String {
        
        var myReturn: String
        
        if abs(number) < 1000 {
            myReturn = String("\(number) \(unit)")
        }
        else if abs(number) < 1000000 {
            let roundedNumber = (Double(number)/1000.0 * 100).rounded() / 100
            myReturn = String("\(roundedNumber) k\(unit)")
        }
        else {
            let roundedNumber = (Double(number)/1000000.0 * 100).rounded() / 100
            myReturn = String("\(roundedNumber) M\(unit)")
        }
        
        return myReturn
    }
}
