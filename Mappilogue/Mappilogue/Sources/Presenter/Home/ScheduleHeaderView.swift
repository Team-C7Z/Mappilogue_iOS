//
//  ScheduleHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

protocol ScheduleTypeDelegate: AnyObject {
    func scheduleButtonTapped(scheduleType: ScheduleType)
}

class ScheduleHeaderView: BaseCollectionReusableView {
    static let registerId = "\(ScheduleHeaderView.self)"
    
    var scheduleType: ScheduleType = .today {
        didSet {
            updateButtonTitleColor()
        }
    }
    
    weak var delegate: ScheduleTypeDelegate?
    
    private let stackView = UIStackView()
    private let todayScheduleButton = UIButton()
    private let upcomingScheduleButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        todayScheduleButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        upcomingScheduleButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 14
        
        todayScheduleButton.setTitle("오늘의 일정", for: .normal)
        todayScheduleButton.setTitleColor(.color1C1C1C, for: .normal)
        todayScheduleButton.titleLabel?.font = .pretendard(.medium, size: 20)
        
        upcomingScheduleButton.setTitle("다가오는 일정", for: .normal)
        upcomingScheduleButton.setTitleColor(.color9B9791, for: .normal)
        upcomingScheduleButton.titleLabel?.font = .pretendard(.medium, size: 20)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        [todayScheduleButton, upcomingScheduleButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func scheduleButtonTapped(_ sender: UIButton) {
        if sender == todayScheduleButton {
            scheduleType = .today
        } else if sender == upcomingScheduleButton {
            scheduleType = .upcoming
        }
        
        delegate?.scheduleButtonTapped(scheduleType: scheduleType)
    }
    
    private func updateButtonTitleColor() {
        todayScheduleButton.setTitleColor(scheduleType == .today ? .color1C1C1C : .color9B9791, for: .normal)
        upcomingScheduleButton.setTitleColor(scheduleType == .upcoming ? .color1C1C1C : .color9B9791, for: .normal)
    }
}
