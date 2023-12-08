//
//  LocationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/8/23.
//

import Foundation
import Combine

class LocationViewModel {
    @Published var addressResult: AddressDocuments?
    @Published var locationResult: [KakaoSearchPlaces]?
    var cancellables: Set<AnyCancellable> = []
    private let locationManager = LocationManager()
    
    func getAddress(long: Double, lat: Double) {
        locationManager.getAddress(long: long, lat: lat)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.addressResult = response.documents[0]
            })
            .store(in: &cancellables)
    }
        
    func getSearchResults(keyword: String, page: Int) {
        locationManager.getSearchResults(keyword: keyword, page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.locationResult = response.kakaoSearchPlaces
            })
            .store(in: &cancellables)
    }
}
