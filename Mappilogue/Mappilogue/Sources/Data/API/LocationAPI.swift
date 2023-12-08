//
//  LocationAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Combine

protocol LocationAPI {
    func getAddress(long: Double, lat: Double) -> AnyPublisher<KakaoAddressDTO, Error>
    func getSearchResults(keyword: String, page: Int) -> AnyPublisher<KakaoSerachDTO, Error>
}
