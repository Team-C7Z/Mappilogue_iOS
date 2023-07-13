//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
    }
    
    func setNavigationBar() {
        title = "일정"
        setNavigationBackButton()
        setNavigationCompletionButton()
    }
    
    func setNavigationBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setNavigationCompletionButton() {
        let completionButton = UIButton(type: .custom)
        completionButton.setImage(UIImage(named: "completion"), for: .normal)
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: completionButton)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func completionButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
