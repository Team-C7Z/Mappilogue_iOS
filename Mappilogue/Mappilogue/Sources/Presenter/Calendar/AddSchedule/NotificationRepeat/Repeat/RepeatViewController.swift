//
//  RepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class RepeatViewController: BaseViewController {
    var selectedRepeatType: RepeatType = .weekday {
        didSet {
            setRepeatButtonDesign()
        }
    }
   
    private let stackView = UIStackView()
    private var weekdayButton = UIButton()
    private var cycleButton = UIButton()
    
    private let containerView = UIView()
    private let weekdayRepeatViewController = WeekdayRepeatViewController()
    private let cycleRepeatViewController = CycleRepeatViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setRepeatButtonDesign()
        showViewController(weekdayRepeatViewController)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar("반복", backButtonAction: #selector(backButtonTapped))
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 14
        
        weekdayButton = createRepeatButton("요일 별")
        cycleButton = createRepeatButton("주기 별")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(weekdayButton)
        stackView.addArrangedSubview(cycleButton)
     
        view.addSubview(containerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createRepeatButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .title02
        button.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    private func setRepeatButtonDesign() {
        weekdayButton.setTitleColor(selectedRepeatType == .weekday ? .color1C1C1C : .color9B9791, for: .normal)
        cycleButton.setTitleColor(selectedRepeatType == .cycle ? .color1C1C1C : .color9B9791, for: .normal)
    }
    
    @objc private func repeatButtonTapped(_ sender: UIButton) {
        switch sender {
        case weekdayButton:
            selectedRepeatType = .weekday
            showViewController(weekdayRepeatViewController)
        case cycleButton:
            selectedRepeatType = .cycle
            showViewController(cycleRepeatViewController)
        default:
            break
        }
    }
    
    private func showViewController(_ viewController: UIViewController) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
}

extension RepeatViewController: WeekdayRepeatDelegate {
    func selecteWeekdayRepeat(weekday: [String], spacing: String, endDate: SelectedDate) {
        
    }
}
