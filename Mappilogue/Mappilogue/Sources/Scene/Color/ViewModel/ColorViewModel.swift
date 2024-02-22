//
//  ColorViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/18.
//

import Foundation
import Combine

class ColorViewModel: ColorAPI {
    var cancellables: Set<AnyCancellable> = []
    private let colorManager = ColorManager()
    
    func getColorList() -> AnyPublisher<BaseDTOResult<[ColorListDTO]>, Error> {
        return colorManager.getColorList()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
