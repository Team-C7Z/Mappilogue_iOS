//
//  CategoryViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/08.
//

import Foundation
import Combine

class CategoryViewModel {
    var cancellables: Set<AnyCancellable> = []
    private let categoryManager = CategoryManager2()
    
    func getCategory() -> AnyPublisher<BaseDTO<GetCategoryDTO>, Error> {
        return categoryManager.getCategory()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func addCategory(title: String) {
        categoryManager.addCategory(title: title)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
    }
}
