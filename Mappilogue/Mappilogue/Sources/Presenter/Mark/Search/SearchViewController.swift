//
//  SearchViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchViewController: BaseViewController {
    private let searchTextField = SearchTextField()
    private let containerView = UIView()
    private let searchResultViewController = SearchResultViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
        
        searchTextField.becomeFirstResponder()
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
       
        view.addSubview(searchTextField)
        view.addSubview(containerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(40)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view)
        }
    }
    
    private func setNavigationBar() {
        title = "검색"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            showViewController(UIViewController())
        } else {
            showViewController(searchResultViewController)
        }
    }
}
