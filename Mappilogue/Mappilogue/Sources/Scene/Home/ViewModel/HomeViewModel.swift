//
//  HomeViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeLoadDataDelegate: AnyObject {
    func reloadView()
}

class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 0)
    weak var delegate: HomeLoadDataDelegate?
    var homeSchedules2: BehaviorRelay<HomeDTO?> = BehaviorRelay(value: nil)
    var homeSchedules: HomeDTO?
    var isScheduleExpanded = [Bool]()
    var isScheduleExpanded2: BehaviorRelay<[Bool]> = BehaviorRelay(value: [])
    
    var selectedScheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
    init() {
        isScheduleExpanded = Array(repeating: true, count: 0)
        isScheduleExpanded2.accept((Array(repeating: true, count: 0)))
    }
    
    func loadHomeData(option: String) {
        HomeManager.shared.getHome(option: option) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<HomeDTO>, let result = baseResponse.result else { return }
                self.homeSchedules = result
                self.isScheduleExpanded = Array(repeating: true, count: self.homeSchedules?.schedules.count ?? 0)
                self.delegate?.reloadView()
            default:
                break
            }
        }
    }
}
