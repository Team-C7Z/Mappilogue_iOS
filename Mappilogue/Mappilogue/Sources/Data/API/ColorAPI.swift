//
//  ColorAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/18.
//

import Foundation
import Combine

protocol ColorAPI {
    func getColorList() -> AnyPublisher<BaseDTOResult<[ColorListDTO]>, Error>
}
