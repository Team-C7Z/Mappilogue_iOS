//
//  AddScheduleHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class AddScheduleHeaderView: BaseCollectionReusableView {
    static let registerId = "\(AddScheduleHeaderView.self)"
    
    private var schedule: Schedule = Schedule()
    private var colorList = dummyColorSelectionData()
    var onStartDateButtonTapped: (() -> Void)?
    var onEndDateButtonTapped: (() -> Void)?
    var onNotificationButtonTapped: (() -> Void)?
    var onRepeatButtonTapped: (() -> Void)?
    
    private let stackView = UIStackView()
    private let scheduleTitleColorView = AddScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let scheduleDurationView = ScheduleDurationView()
    private let notificationButton = NotificationRepeatButton()
    private let repeatButton = NotificationRepeatButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        enterNameTextField()
        toggleColorSelectionView()
        configureScheduleTitleColorView()
        selectColor()
        setDateButtonAction()
        setNotificationRepeatButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.backgroundColor = .colorEAE6E1
    
        notificationButton.configure(imageName: "notification", title: "알림")
        repeatButton.configure(imageName: "repeat", title: "반복")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        stackView.addArrangedSubview(scheduleTitleColorView)
        stackView.addArrangedSubview(colorSelectionView)
        stackView.addArrangedSubview(scheduleDurationView)
        stackView.addArrangedSubview(notificationButton)
        stackView.addArrangedSubview(repeatButton)
        stackView.isUserInteractionEnabled = true
        colorSelectionView.isUserInteractionEnabled = true
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
    }
    
    private func configureScheduleTitleColorView() {
        if let color = schedule.color {
            scheduleTitleColorView.configure(with: schedule.title, color: color, isColorSelection: false)
        } else {
            let randomColorIndex = Int.random(in: 0...14)
            schedule.color = colorList[randomColorIndex]
            colorSelectionView.selectedColorIndex = randomColorIndex
        }
    }
    
    func configureDate(startDate: SelectedDate, endDate: SelectedDate) {
        scheduleDurationView.configure(startDate: startDate, endDate: endDate)
    }
    
    private func setDateButtonAction() {
        scheduleDurationView.startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        scheduleDurationView.endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startDateButtonTapped(_ sender: UIButton) {
        onStartDateButtonTapped?()
    }
    
    @objc private func endDateButtonTapped(_ sender: UIButton) {
        onEndDateButtonTapped?()
    }
    
    private func setNotificationRepeatButtonAction() {
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
    }

    @objc private func notificationButtonTapped() {
        onNotificationButtonTapped?()
    }
    
    @objc private func repeatButtonTapped() {
        onRepeatButtonTapped?()
    }
}

extension AddScheduleHeaderView {
    func enterNameTextField() {
        scheduleTitleColorView.onNameEntered = { [weak self] name in
            guard let self = self else { return }
            
            schedule.title = name
        }
    }
    
    func toggleColorSelectionView() {
        scheduleTitleColorView.onColorSelectionButtonTapped = { [weak self] isSelected in
            guard let self = self else { return }
            
            colorSelectionView.snp.remakeConstraints {
                $0.height.equalTo(isSelected ? 186 : 0)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            
            if let color = schedule.color {
                scheduleTitleColorView.configure(with: schedule.title, color: color, isColorSelection: isSelected)
            }
        }
    }
    
    func selectColor() {
        colorSelectionView.onSelectedColor = { [weak self] selectedColorIndex in
            guard let self = self else { return }
            
            schedule.color = colorList[selectedColorIndex]
            configureScheduleTitleColorView()
        }
    }
}
