//
//  CategoryManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Moya
import Combine

class CategoryManager {
    static let shared = CategoryManager()
    private let provider = MoyaProvider<CategoryAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
    
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
    
    func updateCategoryOrder(categories: [Category], completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.updateCategoryOrder(categories: categories)) { result in
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

class CategoryManager2: CategoryAPI2 {
    private let baseURL = URL(string: "\(Environment.baseURL)/api/v1/marks/categories")!
    
    func getCategory() -> AnyPublisher<BaseDTO<GetCategoryDTO>, Error> {
        let url = baseURL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<GetCategoryDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func addCategory(title: String) -> AnyPublisher<BaseDTO<AddCategoryDTO>, Error> {
        let url = baseURL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let requestParameters: [String: Any] = [
            "title": title
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
            
                return data
            }
            .decode(type: BaseDTO<AddCategoryDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func deleteCategory(deleteCategory: DeleteCategory) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(Environment.baseURL)/api/v1/marks/categories/\(deleteCategory.markCategoryId)?option=\(deleteCategory.option)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw URLError(.badServerResponse)
                }
            
                return
            }
            .eraseToAnyPublisher()
    }
    
    private func setupRequestHeaders() -> [String: String]? {
        guard let token = AuthUserDefaults.accessToken else {
            return nil
        }
        return ["Authorization": "Bearer \(token)"]
    }
}

enum CategoryAPIError: Error {
    case networkError(Error)
    case serializationError(Error)
    case decodingError(Error)
}
