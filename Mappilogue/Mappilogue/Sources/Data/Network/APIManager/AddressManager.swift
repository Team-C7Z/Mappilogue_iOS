//
//  AddressManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/14.
//

import Foundation
import Moya

class AddressManager {
    private let provider = MoyaProvider<AddressAPI>()
    
    func getAddress(long: Double, lat: Double) {
        provider.request(.address(long: long, lat: lat)) { result in
            switch result {
            case .success(let response):
                do {
                    let address = try response.map(KakaoAddressResponse.self)
                    print(address)
                } catch {
                    print("Mapping error: \(error)")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
