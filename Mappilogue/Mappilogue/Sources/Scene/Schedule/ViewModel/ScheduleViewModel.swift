//
//  ScheduleViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine

protocol ScheduleReloadViewDelegate: AnyObject {
    func reloadView()
}

class ScheduleViewModel {
    var scheduleResult: GetScheduleDTO?
    var cancellables: Set<AnyCancellable> = []
    let scheduleManager = ScheduleManager()
    var calendarViewModel = CalendarViewModel()
    
    weak var delegate: ScheduleReloadViewDelegate?
    var onDismiss: (() -> Void)?
    
    var selectedDate: String?
    var scheduleId: Int?
    var schedule = Schedule(colorId: -1, startDate: "", endDate: "")
    
    var startDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    var endDate: SelectedDate  = SelectedDate(year: 0, month: 0, day: 0)
    var scheduleDateType: AddScheduleDateType = .unKnown
    
    let years: [Int] = Array(1970...2050)
    let months: [Int] = Array(1...12)
    var days: [Int] = []
    
    var isColorSelection: Bool = false
    var colorList: [ColorListDTO] = []
    
    var selectedDateIndex = 0
    var isDeleteMode: Bool = false
    
    var area: [Area] = []
    var selectedLocations: [IndexPath] = []
    var initialTime: String = "9:00 AM"
    
    func getSchedule() {
        guard let id = scheduleId else { return }
        
        CalendarManager.shared.getSchedule(id: id) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<GetScheduleDTO>, let result = baseResponse.result else { return }
                self.scheduleResult = result
                self.setScheduleData(getSchedule: result)
                self.delegate?.reloadView()
            default:
                break
            }
        }
    }
    
    func updateSchedule(id: Int, schedule: Schedule) {
        CalendarManager.shared.updateSchedule(id: id, schedule: schedule) { _ in
          //  self.onDismiss?()
        }

    }
    
    func setCurrentDate() {
        days = calendarViewModel.getDays(year: calendarViewModel.currentYear, month: calendarViewModel.currentMonth)
        startDate = .init(year: calendarViewModel.currentYear, month: calendarViewModel.currentMonth, day: calendarViewModel.currentDay)
        endDate = .init(year: calendarViewModel.currentYear, month: calendarViewModel.currentMonth, day: calendarViewModel.currentDay)
    }
    
    func saveSchedule() {
        schedule.startDate = startDate.stringFromSelectedDate()
        schedule.endDate = endDate.stringFromSelectedDate()
        if schedule.colorId == -1 {
            schedule.colorId = colorList.map({$0.id}).randomElement() ?? 0
        }
        
        schedule.area = area.isEmpty ? nil : area
        
        print(schedule, 7667678)
        if let id = scheduleId {
            updateSchedule(id: id, schedule: schedule)
        } else {
            addSchedule(schedule: schedule)
        }
    }
    
    private func addSchedule(schedule: Schedule) {
        CalendarManager.shared.addSchedule(schedule: schedule) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<AddScheduleDTO>, let _ = baseResponse.result else { return }
               // self.onDismiss?()
            default:
                break
            }
        }
    }
    
    func convertStringToInt(date: String) -> SelectedDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let convertedDate = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: convertedDate)
            
            let date = SelectedDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day)
            
            return date
        }
        return SelectedDate(year: 0, month: 0)
    }
    
    func setScheduleData(getSchedule: GetScheduleDTO) {
        schedule = Schedule(
            title: getSchedule.scheduleBaseInfo.title,
            colorId: getSchedule.scheduleBaseInfo.colorId,
            startDate: getSchedule.scheduleBaseInfo.startDate,
            endDate: getSchedule.scheduleBaseInfo.endDate,
            alarmOptions: getSchedule.scheduleAlarmInfo
        )
      
        startDate = convertStringToInt(date: schedule.startDate)
        endDate = convertStringToInt(date: schedule.endDate)
        
        for areaInfo in getSchedule.scheduleAreaInfo {
            let date = areaInfo.date
            var locations = [AddSchduleLocation]()
            for locationInfo in areaInfo.value {
                let location = AddSchduleLocation(
                    name: locationInfo.name,
                    streetAddress: locationInfo.streetAddress,
                    latitude: locationInfo.latitude,
                    longitude: locationInfo.longitude,
                    time: locationInfo.time
                )
                locations.append(location)
            }
            area.append(Area(date: date, value: locations))
        }
    }
    
    func validateDateRange() {
        if calendarViewModel.daysBetween(start: startDate, end: endDate) < 0 {
            if scheduleDateType == .startDate {
                endDate = SelectedDate(year: startDate.year, month: startDate.month, day: startDate.day ?? 0)
            } else if scheduleDateType == .endDate {
                startDate = SelectedDate(year: endDate.year, month: endDate.month, day: endDate.day ?? 0)
            }
        }
    }
    
    func selectLocation(_ location: KakaoSearchPlaces) {
        let dateRange = calendarViewModel.getDatesInRange(startDate: startDate, endDate: endDate)
        for date in dateRange {
            addLocation(date: date, place: location)
        }
    }
    
    func addLocation(date: Date, place: KakaoSearchPlaces) {
        let location = AddSchduleLocation(
            name: place.placeName,
            streetAddress: place.addressName,
            latitude: place.lat.isEmpty ? nil : place.lat,
            longitude: place.long.isEmpty ? nil : place.long,
            time: initialTime
        )
  
        if let index = area.firstIndex(where: {$0.date == date.formatToyyyyMMddDateString()}) {
            area[index].value.append(location)
        } else {
            let schedule = Area(date: date.formatToyyyyMMddDateString(), value: [location])
            area.append(schedule)
        }
    }
    
    func setSelectedTime(selectedTime: String?) -> String {
        guard let time = selectedTime else { return "" }
        
        return time == "설정 안 함" ? initialTime : time
    }
    
    func formatTime(_ time: String) -> String {
        return time.replacingOccurrences(of: "오전", with: "AM").replacingOccurrences(of: "오후", with: "PM")
    }
    
    func toggleSelectedLocation(at indexPath: IndexPath) {
        if let index = selectedLocations.firstIndex(of: indexPath) {
            selectedLocations.remove(at: index)
        } else {
            selectedLocations.append(indexPath)
        }
    }
    
    func deleteSelectedLocations() {
        selectedLocations.sorted(by: >).forEach { indexPath in
            if indexPath.section < area.count && indexPath.row < area[indexPath.section].value.count {
                area[indexPath.section].value.remove(at: indexPath.row)
            }
            if area[indexPath.section].value.isEmpty {
                area.remove(at: indexPath.section)
            }
        }
        selectedLocations = []
    }
    
    func updateLocationPosition(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        let moveLocation = area[sourceIndexPath.section-1].value[sourceIndexPath.row]
        area[sourceIndexPath.section-1].value.remove(at: sourceIndexPath.row)
        area[destinationIndexPath.section-1].value.insert(moveLocation, at: destinationIndexPath.row)
    }
    
    func setYearForSelectedDate(row: Int) {
        if scheduleDateType == .startDate {
            startDate.year = years[row]
        } else if scheduleDateType == .endDate {
            endDate.year = years[row]
        }
    }
    
    func setMonthForSelectedDate(row: Int) {
        if scheduleDateType == .startDate {
            startDate.month = months[row]
        } else if scheduleDateType == .endDate {
            endDate.month = months[row]
        }
    }
    
    func setDayForSelectedDate(row: Int) {
        if scheduleDateType == .startDate {
            startDate.day = days[row]
        } else if scheduleDateType == .endDate {
            endDate.day = days[row]
        }
    }
    
    func updateDaysForSelectedDateType() {
        if scheduleDateType == .startDate {
            updateDaysComponent(startDate)
        } else if scheduleDateType == .endDate {
            updateDaysComponent(endDate)
        }
    }
    
    func updateDaysComponent(_ selectedDate: SelectedDate) {
        days = calendarViewModel.getDays(year: selectedDate.year, month: selectedDate.month)
    }
}
