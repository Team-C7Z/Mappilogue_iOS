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
        
        setKeyboardObservers()
        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("검색", backButtonAction: #selector(backButtonTapped))
        
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
    
    private func showViewController(_ viewController: UIViewController) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
    
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: false)
    }
    
    private func keyboardWillChange(_ notification: Notification, isShowing: Bool) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        searchResultViewController.keyboardHeight = isShowing ? keyboardHeight + 16 : 44
        searchResultViewController.collectionView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
