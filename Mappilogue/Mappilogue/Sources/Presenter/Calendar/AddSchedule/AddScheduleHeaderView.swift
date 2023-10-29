//
//  AddScheduleHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class AddScheduleHeaderView: BaseCollectionReusableView {
    static let registerId = "\(AddScheduleHeaderView.self)"
    
    private var title: String = ""
    private var colorList: [ColorListDTO] = []
    private var colorId: Int = -1
    private var isColorSelection: Bool = false
    
    var onScheduleTitle: ((String) -> Void)?
    var onColorSelectionButtonTapped: (() -> Void)?
    var onColorIndex: ((Int) -> Void)?
    var onStartDateButtonTapped: ((AddScheduleDateType) -> Void)?
    var onEndDateButtonTapped: ((AddScheduleDateType) -> Void)?
    var onNotificationButtonTapped: (() -> Void)?
    var onRepeatButtonTapped: (() -> Void)?
    
    private let titleColorStackView = UIStackView()
    private let stackView = UIStackView()
    private let scheduleTitleColorView = ScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let scheduleDurationView = ScheduleDurationView()
    private let notificationButton = NotificationRepeatButton()
    private let repeatButton = NotificationRepeatButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        enterNameTextField()
        toggleColorSelectionView()
        selectColor()
        setDateButtonAction()
        setNotificationRepeatButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleColorStackView.axis = .vertical
        titleColorStackView.distribution = .equalSpacing
        titleColorStackView.spacing = 0
        
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
        stackView.addArrangedSubview(titleColorStackView)
        titleColorStackView.addArrangedSubview(scheduleTitleColorView)
        titleColorStackView.addArrangedSubview(colorSelectionView)
        stackView.addArrangedSubview(scheduleDurationView)
        stackView.addArrangedSubview(notificationButton)
        stackView.addArrangedSubview(repeatButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
    }
    
    func configureTitleColor(title: String, isColorSelection: Bool, colorId: Int) {
        self.title = title
        self.isColorSelection = isColorSelection
        self.colorId = colorId
    }
    
    func configureColorList(_ colorList: [ColorListDTO]) {
        self.colorList = colorList
        configureScheduleTitleColorView()
    }
 
    private func configureScheduleTitleColorView() {
        if colorId >= 0 {
            if let index = colorList.firstIndex(where: {$0.id == colorId}) {
                let colorCode = colorList[index].code
                let color = UIColor.fromHex(colorCode)
                scheduleTitleColorView.configure(true, title: title, colorId: colorId, color: color, isColorSelection: isColorSelection)
            }
        } else {
            guard let randomColorId = colorList.map({$0.id}).randomElement() else { return }
            colorId = randomColorId
        }
        
        colorSelectionView.configure(colorId, colorList: colorList)
    }
    
    func configureDate(startDate: SelectedDate, endDate: SelectedDate, dateType: AddScheduleDateType) {
        scheduleDurationView.configure(startDate: startDate, endDate: endDate, dateType: dateType)
    }
    
    private func setDateButtonAction() {
        scheduleDurationView.startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        scheduleDurationView.endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startDateButtonTapped(_ sender: UIButton) {
        onStartDateButtonTapped?(.startDate)
    }
    
    @objc private func endDateButtonTapped(_ sender: UIButton) {
        onEndDateButtonTapped?(.endDate)
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
            onScheduleTitle?(name)
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
            
            if let index = colorList.firstIndex(where: {$0.id == self.colorId}) {
                let colorCode = colorList[index].code
                let color = UIColor.fromHex(colorCode)
                scheduleTitleColorView.configure(true, title: title, colorId: colorId, color: color, isColorSelection: isColorSelection)
            }

            onColorSelectionButtonTapped?()
        }
    }
    
    func selectColor() {
        colorSelectionView.onSelectedColor = { [weak self] selectedColorId in
            guard let self = self else { return }
        
            onColorIndex?(selectedColorId)
            configureScheduleTitleColorView()
        }
    }
}
