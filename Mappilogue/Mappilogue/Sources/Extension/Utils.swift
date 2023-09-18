//
//  Utils.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/18.
//

import Foundation

class Utils {
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    static func loadAppStoreVersion() -> String {
        let bundleID = "id"
        let appStoreUrl = "http://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: appStoreUrl),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]] else {
            return ""
        }
                
        guard let appStoreVersion = results[0]["version"] as? String else {
            return ""
        }
                        
        return appStoreVersion
    }
}
