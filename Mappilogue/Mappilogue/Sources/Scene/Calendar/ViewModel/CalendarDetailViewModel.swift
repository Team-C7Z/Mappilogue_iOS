//
//  CalendarDetailViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation
import Combine

class CalendarDetailViewModel {
    @Published var scheduleDetailResult: ScheduleDetailDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let calendarManager = CalendarManager()
    
    var date: String = ""
    var schedules = ScheduleDetailDTO(solarDate: "", lunarDate: "", schedulesOnSpecificDate: [])
    var selectedScheduleIndex: Int?
    
    func getScheduleDetail(date: String) {
        calendarManager.getScheduleDetail(date: date)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.scheduleDetailResult = response.result
            })
            .store(in: &cancellables)
    }
    
    func deleteSchedule(id: Int, date: String) {
        calendarManager.deleteSchedule(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.getScheduleDetail(date: date)
                case .failure:
                    print("error")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func setDate(date: String) -> String {
        let dateArr = date.split(separator: " ").map {String($0)}
        let (dateMonth, dateDay) = (dateArr[1], dateArr[2])
        
        return dateMonth + " " + dateDay
    }
    
}
