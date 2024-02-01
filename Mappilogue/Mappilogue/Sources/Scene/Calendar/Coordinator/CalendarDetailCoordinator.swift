//
//  CalendarDetailCoordinator.swift
//  Mappilogue
//
//  Created by hyemi on 12/16/23.
//

import MappilogueKit

protocol CalendarDetailDelegate: AnyObject {
    func showEditScheduleViewController()
    func dismissViewController()
}

protocol ShowAddScheduleDelegate: AnyObject {
    func showAddScheduleViewController()
}

class CalendarDetailCoordinator: BaseCoordinator, CalendarDetailDelegate {
    override func start() { }
    
    weak var delegate: ShowAddScheduleDelegate?
    
    func showCalendarDetailViewController(date: String, frame: CGRect) {
        let calendarDetailViewController = CalendarDetailViewController()
        calendarDetailViewController.modalPresentationStyle = .overFullScreen
        calendarDetailViewController.coordinator = self
        calendarDetailViewController.viewModel.date = date
        calendarDetailViewController.addButtonLocation = frame
        navigationController.present(calendarDetailViewController, animated: false)
    }
    
    func showEditScheduleViewController() {
        let editViewController = EditBottomSheetViewController()
        editViewController.modalPresentationStyle = .overFullScreen
        editViewController.configure(modifyTitle: "기록 작성하기",
                                             deleteTitle: "일정 삭제하기",
                                             alert: Alert(titleText: "이 일정을 삭제할까요?",
                                                          messageText: nil,
                                                          cancelText: "취소",
                                                          doneText: "삭제",
                                                          buttonColor: .redF14C4C,
                                                          alertHeight: 140))
     //   editViewController.onModify = { self.showWriteRecordViewController() }
     //   editViewController.onDelete = { self.deleteSchedule() }
        navigationController.present(editViewController, animated: false)
    }
    
    func showAddScheduleViewController() {
        dismissViewController()
        delegate?.showAddScheduleViewController()
    }
    
    func dismissViewController() {
        childDidFinish(self)
        navigationController.dismiss(animated: false)
    }
}
