//
//  ScheduleViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine

class ScheduleViewModel {
    @Published var scheduleResult: GetScheduleDTO?
    var cancellables: Set<AnyCancellable> = []
    private let scheduleManager = ScheduleManager()
    
    func addSchedule(schedule: Schedule) {
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
    
    func getSchedule(id: Int) {
        scheduleManager.getSchedule(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { result in
                self.scheduleResult = result.result
            })
            .store(in: &cancellables)
    }
    
    func updateSchedule(id: Int, schedule: Schedule) {
        scheduleManager.updateSchedule(id: id, schedule: schedule)
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
