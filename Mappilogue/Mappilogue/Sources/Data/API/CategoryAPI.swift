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
    func updateCategory(updateCategory: UpdateCategory) -> AnyPublisher<Void, Error>
    func deleteCategory(deleteCategory: DeleteCategory) -> AnyPublisher<Void, Error>
//    func updateCategoryOrder(categories: [Category]) -> AnyPublisher<[Category], Error>
}

enum CategoryAPI: BaseAPI {
    case updateCategoryOrder(categories: [Category])
}

extension CategoryAPI: TargetType {
    var path: String {
        switch self {
        case .updateCategoryOrder:
            return "/api/v1/marks/categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateCategoryOrder:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .updateCategoryOrder(categories):
            var requestParameters: [String: Any] = [:]
            requestParameters["categories"] = categories.map { category in
                return [
                    "id": category.id,
                    "isMarkedInMap": category.isMarkedInMap
                ] as [String: Any]
            }
            
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        
        return ["Authorization": "Bearer \(token)"]
    }
}
