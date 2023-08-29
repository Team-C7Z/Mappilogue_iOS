//
//  LocationManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Moya

class LocationManager {
    static let shared = LocationManager()
    
    private let provider = MoyaProvider<LocationAPI>()

    func getAddress(long: Double, lat: Double, completion: @escaping (AddressDocuments?) -> Void) {
        provider.request(.getAddress(long: long, lat: lat)) { result in
            switch result {
            case .success(let response):
                do {
                    let kakaoAddress = try response.map(KakaoAddressResponse.self)
                    if let address = kakaoAddress.documents.first {
                        completion(address)
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
    
    func getSearchResults(keyword: String, page: Int, completion: @escaping ([KakaoSearchPlaces]?) -> Void) {
        provider.request(.search(keyword: keyword, page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let searchPlace = try response.map(KakaoSerachResponse.self)
                    completion(searchPlace.kakaoSearchPlaces)
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
