//
//  ScheduleAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Combine

protocol ScheduleAPI {
    func updateSchedule(id: Int, schedule: Schedule) -> AnyPublisher<Void, Error>
}
