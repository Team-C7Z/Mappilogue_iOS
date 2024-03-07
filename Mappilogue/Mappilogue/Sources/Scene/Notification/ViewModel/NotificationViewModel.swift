//
//  NotificationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import RxDataSources

protocol AnnouncementDelegate: AnyObject {
    func getAnnouncement()
}

class NotificationViewModel {
    let disposeBag = DisposeBag()
    
    weak var delegate: AnnouncementDelegate?
    var notificationData = [NotificationData]()
    var isAnnouncementExpanded = [Bool]()
    var notifications = PublishSubject<[NotificationData]>()
    var announcements1 = PublishSubject<[AnnouncementDTO]>()
    var isAnnouncementExpanded1 = BehaviorRelay<[Bool]>(value: [])
    var notificationType: NotificationType = .announcement
    let data: BehaviorRelay<[SectionModel<String, CellType>]> = BehaviorRelay(value: [])
    
    var currentPage = 1
    var totalPage = 10
    var isLoading = false
    
//    init() {
//        isAnnouncementExpanded = Array(repeating: false, count: announcements.count)
//    }
    
    func removeNotification(at index: Int) {
        notificationData.remove(at: index)
    }
    
    func getAnnouncementData(pageNo: Int) {
        HomeManager.shared.getAnnouncement(pageNo: pageNo) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<[AnnouncementDTO]>, let result = baseResponse.result else { return }
                self.isLoading = false
            //    self.announcements += result
                self.currentPage += 1
                for _ in 0..<10 {
                    self.isAnnouncementExpanded.append(false)
                }
                self.delegate?.getAnnouncement()
            default:
                break
            }
        }
   }
    
    func getAnnouncements(pageNo: Int) {
        HomeManager.shared.getAnnouncement1(pageNo: pageNo)
            .subscribe(onSuccess: { [weak self] result in
                switch result {
                case .success(let response):
                    if let result = response.result {
                       self?.announcements1.onNext(result)
                        self?.isAnnouncementExpanded1.accept(Array(repeating: false, count: result.count))
                    }
                case .requestError(_):
                    print("receivedTagFetchWithAPI - requestErr")
                case .pathError:
                    print("receivedTagFetchWithAPI - pathErr")
                case .serverError:
                    print("receivedTagFetchWithAPI - serverErr")
                case .networkFail:
                    print("receivedTagFetchWithAPI - networkFail")
                }
            })
            .disposed(by: disposeBag)
    }
}
