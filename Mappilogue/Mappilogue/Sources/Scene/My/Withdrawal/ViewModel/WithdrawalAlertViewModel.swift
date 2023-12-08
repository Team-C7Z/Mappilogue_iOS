//
//  WithdrawalAlertViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/8/23.
//

import Foundation

class WithdrawalAlertViewModel {
    var isChecked: Bool = false
    
    var onDeleteButtonTapped: (() -> Void)?
    
    func toggleCheck() {
        isChecked = !isChecked
    }
    
    func performDelete() {
        onDeleteButtonTapped?()
    }
}
