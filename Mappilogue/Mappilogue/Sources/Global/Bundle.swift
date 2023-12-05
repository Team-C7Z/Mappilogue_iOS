//
//  Bundle.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        return key
    }
    
    var kakaoApiKey: String {
        guard let file = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KAKAO_API_KEY"] as? String else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        return key
    }
    
    var kakaoRestKey: String {
        guard let file = Bundle.main.path(forResource: "SecureAPIKeys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KAKAO_REST_KEY"] as? String else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        return key
    }
}
