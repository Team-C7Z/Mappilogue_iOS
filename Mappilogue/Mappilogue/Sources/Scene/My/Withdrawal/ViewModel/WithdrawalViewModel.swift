//
//  WithdrawalViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/8/23.
//

import UIKit
import Combine

class WithdrawalViewModel {
    var cancellables: Set<AnyCancellable> = []
    private let authManager = AuthManager2()
    
    var withdrawalReasons: [String] = [
          "이제 이 서비스가 필요하지 않아요",
          "어플이 사용하기 어려워요",
          "어플에 오류가 있어요",
          "재가입을 하고 싶어요",
          "기능들이 마음에 들지 않거나 부족해요",
          "기타"
      ]
    
    var selectedReasons: [Bool] = []
    
    var isSelectedReason: Bool {
        return selectedReasons.contains(true)
    }
    
    var withdrawalReasonText: String {
        return isSelectedReason ? setWithdrawlReason() : ""
    }
    
    func updateSelectedReasons(_ index: Int) {
        selectedReasons[index] = !selectedReasons[index]
    }
    
    private func setWithdrawlReason() -> String {
        var reasons: [String] = []
        for (index, selectedReason) in selectedReasons.enumerated() where selectedReason {
            reasons.append(withdrawalReasons[index])
        }
        return reasons.joined(separator: " / ")
    }
    
    func withdrawal(reason: String?) -> AnyPublisher<Void, Error> {
        authManager.withdrawal(reason: reason)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
