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
           showWeekdayRepeatViewController()
       }
   }
    private let stackView = UIStackView()
    private let weekdayButton = UIButton()
    private let cycleButton = UIButton()
    
    private let continerView = UIView()
    private let weekdayRepeatViewController = WeekdayRepeatViewController()
    private let cycleRepeatViewController = CycleRepeatViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        showWeekdayRepeatViewController()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 14
        
        weekdayButton.setTitle("요일 별", for: .normal)
        weekdayButton.titleLabel?.font = .title02
        weekdayButton.setTitleColor(.color1C1C1C, for: .normal)
        
        cycleButton.setTitle("주기 별", for: .normal)
        cycleButton.titleLabel?.font = .title02
        cycleButton.setTitleColor(.color9B9791, for: .normal)
        
        weekdayButton.addTarget(self, action: #selector(showWeekdayRepeatViewController), for: .touchUpInside)
        cycleButton.addTarget(self, action: #selector(showCycleRepeatViewController), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(stackView)
        [weekdayButton, cycleButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(continerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        continerView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavigationBar() {
        title = "알림"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func repeatButtonTapped(_ sender: UIButton) {
        switch sender {
        case weekdayButton:
            selectedRepeatType = .weekday
        case cycleButton:
            selectedRepeatType = .cycle
        default:
            break
        }
    }
    
    @objc func showWeekdayRepeatViewController() {
        weekdayButton.setTitleColor(.color1C1C1C, for: .normal)
        cycleButton.setTitleColor(.color9B9791, for: .normal)
        
        cycleRepeatViewController.removeFromParent()
        cycleRepeatViewController.view.removeFromSuperview()
        
        addChild(weekdayRepeatViewController)
        continerView.addSubview(weekdayRepeatViewController.view)
    
        weekdayRepeatViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        weekdayRepeatViewController.didMove(toParent: self)
    }
    
    @objc func showCycleRepeatViewController() {
        weekdayButton.setTitleColor(.color9B9791, for: .normal)
        cycleButton.setTitleColor(.color1C1C1C, for: .normal)
        
        weekdayRepeatViewController.removeFromParent()
        weekdayRepeatViewController.view.removeFromSuperview()
        
        addChild(cycleRepeatViewController)
        continerView.addSubview(cycleRepeatViewController.view)
        
        cycleRepeatViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cycleRepeatViewController.didMove(toParent: self)
    }
}
