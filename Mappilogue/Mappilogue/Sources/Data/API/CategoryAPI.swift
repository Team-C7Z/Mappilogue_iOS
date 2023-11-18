//
//  CategoryAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Combine

protocol CategoryAPI {
    func addCategory(title: String) -> AnyPublisher<BaseDTO<AddCategoryDTO>, Error>
    func getCategory() -> AnyPublisher<BaseDTO<GetCategoryDTO>, Error>
    func updateCategory(updateCategory: UpdatedCategory) -> AnyPublisher<Void, Error>
    func deleteCategory(deleteCategory: DeletedCategory) -> AnyPublisher<Void, Error>
    func updateCategoryOrder(categories: [Category]) -> AnyPublisher<Void, Error>
}
