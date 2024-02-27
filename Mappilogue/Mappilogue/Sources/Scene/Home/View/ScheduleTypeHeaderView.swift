//
//  ScheduleTypeHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

protocol ScheduleTypeDelegate: AnyObject {
    func scheduleButtonTapped(scheduleType: ScheduleType)
}

class ScheduleTypeHeaderView: BaseTableViewHeaderFooterView {
    static let registerId = "\(ScheduleTypeHeaderView.self)"

    var scheduleType: ScheduleType = .today {
        didSet {
            updateButtonTitleColor()
        }
    }
    
    weak var delegate: ScheduleTypeDelegate?
    
    private let stackView = UIStackView()
    private let todayScheduleButton = UIButton()
    private let upcomingScheduleButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        todayScheduleButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        upcomingScheduleButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 14
        
        todayScheduleButton.setTitle("오늘의 일정", for: .normal)
        todayScheduleButton.titleLabel?.font = .title01
        todayScheduleButton.setTitleColor(.black1C1C1C, for: .normal)
        
        upcomingScheduleButton.setTitle("다가오는 일정", for: .normal)
        upcomingScheduleButton.titleLabel?.font = .title01
        upcomingScheduleButton.setTitleColor(.gray9B9791, for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(todayScheduleButton)
        stackView.addArrangedSubview(upcomingScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.bottom.leading.equalTo(contentView)
        }
    }
    
    @objc private func scheduleButtonTapped(_ sender: UIButton) {
        switch sender {
        case todayScheduleButton:
            scheduleType = .today
        case upcomingScheduleButton:
            scheduleType = .upcoming
        default:
            break
        }
        
        delegate?.scheduleButtonTapped(scheduleType: scheduleType)
    }
    
    private func updateButtonTitleColor() {
        todayScheduleButton.setTitleColor(scheduleType == .today ? .black1C1C1C : .gray9B9791, for: .normal)
        upcomingScheduleButton.setTitleColor(scheduleType == .upcoming ? .black1C1C1C : .gray9B9791, for: .normal)
    }
}
