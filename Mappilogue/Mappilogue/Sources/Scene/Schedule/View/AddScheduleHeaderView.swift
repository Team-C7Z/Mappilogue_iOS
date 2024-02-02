//
//  AddScheduleHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit
import MappilogueKit

class AddScheduleHeaderView: BaseCollectionReusableView {
    static let registerId = "\(AddScheduleHeaderView.self)"
    
    private var title: String = ""
    private var colorList: [ColorListDTO] = []
    private var colorId: Int = -1
    private var isColorSelection: Bool = false
    
    var onScheduleTitle: ((String) -> Void)?
    var onColorSelectionButtonTapped: (() -> Void)?
    var onColorIndex: ((Int) -> Void)?
    var onSelectedDateButtonTapped: ((AddScheduleDateType) -> Void)?
    var onNotificationButtonTapped: (() -> Void)?
    
    private let titleColorStackView = UIStackView()
    private let stackView = UIStackView()
    private let scheduleTitleColorView = ScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let scheduleDurationView = ScheduleDurationView()
    private let notificationButton = NotificationRepeatButton()
    
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
        stackView.backgroundColor = .grayEAE6E1
    
        notificationButton.configure(imageName: Images.image(named: .imageScheduleNotification), title: "알림")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleColorStackView)
        titleColorStackView.addArrangedSubview(scheduleTitleColorView)
        titleColorStackView.addArrangedSubview(colorSelectionView)
        stackView.addArrangedSubview(scheduleDurationView)
        stackView.addArrangedSubview(notificationButton)
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
        if let index = colorList.firstIndex(where: {$0.id == colorId}) {
            let colorCode = colorList[index].code
            let color = UIColor.fromHex(colorCode)
            scheduleTitleColorView.configure(true, title: title, colorId: colorId, color: color)
        }
    }
    
    func configureDate(startDate: SelectedDate, endDate: SelectedDate, dateType: AddScheduleDateType) {
        scheduleDurationView.configure(startDate: startDate, endDate: endDate, dateType: dateType)
    }
    
    private func setDateButtonAction() {
        scheduleDurationView.startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        scheduleDurationView.endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startDateButtonTapped(_ sender: UIButton) {
        onSelectedDateButtonTapped?(.startDate)
    }
    
    @objc private func endDateButtonTapped(_ sender: UIButton) {
        onSelectedDateButtonTapped?(.endDate)
    }
    
    private func setNotificationRepeatButtonAction() {
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
    }

    @objc private func notificationButtonTapped() {
        onNotificationButtonTapped?()
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
            
            if colorId == -1 {
                guard let randomColorId = colorList.map({$0.id}).randomElement() else { return }
                colorId = randomColorId
            }
          
            if let index = colorList.firstIndex(where: {$0.id == self.colorId}) {
                let colorCode = colorList[index].code
                let color = UIColor.fromHex(colorCode)
                scheduleTitleColorView.configure(true, title: title, colorId: colorId, color: color)
            }
            
            colorSelectionView.configure(colorId, colorList: colorList)
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
