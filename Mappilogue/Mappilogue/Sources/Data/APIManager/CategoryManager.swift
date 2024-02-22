//
//  CategoryManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Combine

class CategoryManager: CategoryAPI {
    private let baseURL = URL(string: "\(Environment.baseURL)/api/v1/marks/categories")!
    
    func getCategory() -> AnyPublisher<BaseDTOResult<GetCategoryDTO>, Error> {
        let request = setupRequest(for: baseURL, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTOResult<GetCategoryDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func addCategory(title: String) -> AnyPublisher<BaseDTOResult<AddCategoryDTO>, Error> {
        var request = setupRequest(for: baseURL, method: "POST")
        
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
            .decode(type: BaseDTOResult<AddCategoryDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateCategory(updateCategory: UpdatedCategory) -> AnyPublisher<Void, Error> {
        var request = setupRequest(for: baseURL, method: "PATCH")
        
        let requestParameters: [String: Any] = [
            "markCategoryId": updateCategory.markCategoryId,
            "title": updateCategory.title
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
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
    
    func updateCategoryOrder(categories: [Category]) -> AnyPublisher<Void, Error> {
        var request = setupRequest(for: baseURL, method: "PUT")
        
        let requestParameters: [String: Any] = [
            "categories": categories.map { category in
                return [
                    "id": category.id,
                    "isMarkedInMap": category.isMarkedInMap.rawValue
                ] as [String: Any]
            }
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
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
    
    func deleteCategory(deleteCategory: DeletedCategory) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)\(deleteCategory.markCategoryId)?option=\(deleteCategory.option)")!

        let request = setupRequest(for: url, method: "DELETE")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw URLError(.badServerResponse)
                }
                
                return
            }
            .eraseToAnyPublisher()
    }
    
    private func setupRequest(for url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

enum CategoryAPIError: Error {
    case networkError(Error)
    case serializationError(Error)
    case decodingError(Error)
    case apiFailure(ErrorDTO)
}

struct EmptyResponse: Decodable {
}
