//
//  Constants.swift
//  solarLogUI
//
//  Created by Holger Preu on 10.06.21.
//

import Foundation

struct Constants {
    
    struct Network {
        static let baseUrl = getBaseUrl()
        static let basic_auth_user = "holger"
        static let basic_auth_password = "cqXs40me"
        static let useBasicAuth = true
        static let useEncryption = true
        static let useCustomPort = true
        static let customPort = "8524"
        
        
        static var url:String {
            var urlTmp:String
            
            urlTmp = "http"
            urlTmp += useEncryption ? "s://" : "://"
            urlTmp += baseUrl
            urlTmp += useCustomPort ? ":" + customPort : ""
            urlTmp += "/getjp"
            
            return urlTmp
        }
        
        static func getBaseUrl() -> String {
            
            if let tmp = Utilities.retrieveSettings(key: "baseUrl") {
                return tmp as! String
            }
            else {
                return ""
            }
        }
    }
}
