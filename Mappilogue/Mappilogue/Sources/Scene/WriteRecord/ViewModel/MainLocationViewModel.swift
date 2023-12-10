//
//  MainLocationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/10/23.
//

import Foundation

class MainLocationViewModel {
    var selectedMapLocation: Location?
    let dummyLocation = dummyMainLocationData()
    var selectedLocationIndex: Int?
    
    init() {
        selectedLocationIndex = dummyLocation[0].address.isEmpty ? 1 : 0
    }
    
    func selectMapLocation(_ address: String) {
        selectedMapLocation = Location(title: address, address: address)
        selectedLocationIndex = -1
    }
    
    func selectMainLocation(_ index: Int?) {
        selectedLocationIndex = index
        
    }
}
