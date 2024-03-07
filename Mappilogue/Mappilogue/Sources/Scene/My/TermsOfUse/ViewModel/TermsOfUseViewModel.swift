//
//  TermsOfUseViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

protocol TermsOfUseDelegate: AnyObject {
    func getTermsOfUser(url: String)
}

class TermsOfUseViewModel {
    weak var delegate: TermsOfUseDelegate?
    
    func getTermsOfUse() {
        MyManager.shared.termsOfUse { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<TermsOfUseDTO>, let result = baseResponse.result else { return }
                self.delegate?.getTermsOfUser(url: result.link)
            default:
                break
            }
        }
    }
}
