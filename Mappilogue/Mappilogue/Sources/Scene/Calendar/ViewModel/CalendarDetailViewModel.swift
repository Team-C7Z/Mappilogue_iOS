//
//  CalendarDetailViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

protocol CalendarDetailLoadDataDelegate: AnyObject {
    func reloadView()
}

class CalendarDetailViewModel {
    weak var delegate: CalendarDetailLoadDataDelegate?
    
    var date: String = ""
    var schedules = CalendarDetailDTO(solarDate: "", lunarDate: "", schedulesOnSpecificDate: [])
    var scheduleId: Int?
    
    func setDate(date: String) -> String {
        let dateArr = date.split(separator: " ").map {String($0)}
        let (dateMonth, dateDay) = (dateArr[1], dateArr[2])
        
        return dateMonth + " " + dateDay
    }
    
    func loadCalendarDetailData() {
        CalendarManager.shared.getScheduleDetail(date: self.date) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<CalendarDetailDTO>, let result = baseResponse.result else { return }
                self.schedules = result
                self.delegate?.reloadView()
            default:
                break
            }
        }
    }
    
    func deleteSchedule() {
        guard let id = scheduleId else { return }
        CalendarManager.shared.deleteSchedule(id: id, completion: { _ in
            self.loadCalendarDetailData()
        })
    }
}
