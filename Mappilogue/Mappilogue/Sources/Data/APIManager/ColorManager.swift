//
//  ColorManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/18.
//

import Foundation
import Combine

class ColorManager: ColorAPI {
    private let baseURL = URL(string: "\(Environment.baseURL)/api/v1/colors")!
    
    func getColorList() -> AnyPublisher<BaseDTO<[ColorListDTO]>, Error> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<[ColorListDTO]>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
