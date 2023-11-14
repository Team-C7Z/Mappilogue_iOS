//
//  CategoryAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Combine
import Moya

protocol CategoryAPI2 {
    func addCategory(title: String) -> AnyPublisher<BaseDTO<AddCategoryDTO>, Error>
    func getCategory() -> AnyPublisher<BaseDTO<GetCategoryDTO>, Error>
//    func updateCategory(id: Int, title: String) -> AnyPublisher<Category, Error>
//    func deleteCategory(id: Int) -> AnyPublisher<Void, Error>
//    func updateCategoryOrder(categories: [Category]) -> AnyPublisher<[Category], Error>
}

enum CategoryAPI: BaseAPI {
    case addCategory(title: String)
    case updateCategory(id: Int, title: String)
    case deleteCategory(id: Int)
    case updateCategoryOrder(categories: [Category])
}

extension CategoryAPI: TargetType {
    var path: String {
        switch self {
        case .addCategory:
            return "/api/v1/marks/categories"
        case .updateCategory:
            return "/api/v1/marks/categories/titles"
        case .deleteCategory(let id):
            return "/api/v1/marks/categories/\(id)"
        case .updateCategoryOrder:
            return "/api/v1/marks/categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addCategory:
            return .post
        case .updateCategory:
            return .patch
        case .deleteCategory:
            return .delete
        case .updateCategoryOrder:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .addCategory(title):
            let requestParameters: [String: String] = [
                "title": title
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        case let .updateCategory(id, title):
            let requestParameters: [String: Any] = [
                "categoryId": id,
                "title": title
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
            
        case let .updateCategoryOrder(categories):
            var requestParameters: [String: Any] = [:]
            requestParameters["categories"] = categories.map { category in
                return [
                    "id": category.id,
                    "isMarkedInMap": category.isMarkedInMap
                ] as [String: Any]
            }
             
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        
        return ["Authorization": "Bearer \(token)"]
    }
}
