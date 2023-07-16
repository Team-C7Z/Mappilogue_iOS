//
//  RepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class RepeatViewController: BaseViewController {

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
}
