//
//  LocationManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Combine

class LocationManager: LocationAPI {
    private let baseURL = Environment.kakaoAPI
    
    func getAddress(long: Double, lat: Double) -> AnyPublisher<KakaoAddressDTO, Error> {
        let url = URL(string: "\(baseURL)/v2/local/geo/coord2address?x=\(long)&y=\(lat)")!
        let request = setupRequest(for: url, method: "GET")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: KakaoAddressDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getSearchResults(keyword: String, page: Int) -> AnyPublisher<KakaoSerachDTO, Error> {
        let url = URL(string: "\(baseURL)/v2/local/search/keyword?query=\(keyword)&page=\(page)")!
        let request = setupRequest(for: url, method: "GET")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: KakaoSerachDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func setupRequest(for url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("KakaoAK \(Environment.kakaoRestKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
