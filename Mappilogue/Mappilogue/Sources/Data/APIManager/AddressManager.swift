//
//  AddressManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Moya

class AddressManager {
    private let provider = MoyaProvider<AddressAPI>()

    func getAddress(long: Double, lat: Double, completion: @escaping (String?) -> Void) {
        provider.request(.getAddress(long: long, lat: lat)) { result in
            switch result {
            case .success(let response):
                do {
                    let kakaoAddress = try response.map(KakaoAddressResponse.self)
                    if let address = kakaoAddress.documents.first {
                        completion(address.address.addressName)
                    }
                } catch {
                    print("Mapping error: \(error)")
                    completion(nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
