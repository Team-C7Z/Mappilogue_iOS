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
                print(data, response, 44)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
            
                return data
            }
            .decode(type: BaseDTO<AddCategoryDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateCategory(updateCategory: UpdateCategory) -> AnyPublisher<Void, Error> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "PATCH"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
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
        var request = URLRequest(url: baseURL)
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
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
    
    func deleteCategory(deleteCategory: DeleteCategory) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(Environment.baseURL)/api/v1/marks/categories/titles)")!
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
    case apiFailure(ErrorDTO)
}

struct EmptyResponse: Decodable {
}
