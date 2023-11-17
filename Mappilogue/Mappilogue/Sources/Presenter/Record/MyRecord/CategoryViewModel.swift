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
    
    func updateCategory(updateCategory: UpdateCategory) {
        categoryManager.updateCategory(updateCategory: updateCategory)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            } receiveValue: { _ in
    
            }
            .store(in: &cancellables)
    }
    
    func deleteCategory(deleteCategory: DeleteCategory) {
        categoryManager.deleteCategory(deleteCategory: deleteCategory)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            } receiveValue: { _ in
    
            }
            .store(in: &cancellables)
    }
}
