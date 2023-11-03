//
//  CategoryManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Moya

class CategoryManager {
    static let shared = CategoryManager()
    private let provider = MoyaProvider<CategoryAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
    
    func addCategory(title: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.addCategory(title: title)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<AddCategoryDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategory(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getCategory) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<GetCategoryDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateCategory(id: Int, title: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.updateCategory(id: id, title: title)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<String>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(_ statusCode: Int, _ data: Data, _ dataModel: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200...204:
            guard let decodedData = try? decoder.decode(dataModel.self, from: data) else { return .pathError }
            return .success(decodedData)
        case 400:
            guard let decodedData = try? decoder.decode(ErrorDTO.self, from: data) else { return .pathError }
            return .requestError(decodedData)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}
