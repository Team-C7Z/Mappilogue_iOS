//
//  ScheduleViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine

class ScheduleViewModel {
    var cancellables: Set<AnyCancellable> = []
    private let scheduleManager = ScheduleManager()
    
    func addSchedule(schedule: AddSchedule) {
        scheduleManager.addSchedule(schedule: schedule)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellables)
    }
}
