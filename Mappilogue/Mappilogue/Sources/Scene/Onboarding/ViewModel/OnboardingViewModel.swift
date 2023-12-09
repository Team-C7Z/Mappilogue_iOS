//
//  OnboardingViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

class OnboardingViewModel {
    var currentPage: Int = 0
    var onPageChanged: ((Int) -> Void)?
    let onboardingPages = [
        Onboarding(title: "일정에 여러 장소를 추가해 보세요", image: "onboarding1"),
        Onboarding(title: "내 일정을 기반으로 하루를 기록해 보세요", image: "onboarding2"),
        Onboarding(title: "지도로 내 기록을 한 눈에 볼 수 있어요", image: "onboarding3")
    ]
    
    func setStartButton() -> Bool {
        return currentPage == onboardingPages.count - 1
    }
}
