//
//  WriteMarkViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class WriteMarkViewController: BaseViewController {
    var schedule: Schedule?
    var textContentCellHeight: CGFloat = 80
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let categoryButton = CategoryButton()
    private let scheduleTitleColorView = ScheduleTitleColorView()
    private let colorSelectionView = ColorSelectionView()
    private let mainLocationButton = MainLocationButton()
    private let textContentView = TextContentView()
    private let saveMarkView = SaveMarkView()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setKeyboardObservers()
        configureScheduleTitleColorView()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
       
        textContentView.stackViewHeightUpdated = { [weak self] in
            self?.stackView.layoutIfNeeded()
        }
        
        saveMarkView.hideKeyboardButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(categoryButton)
        stackView.addArrangedSubview(scheduleTitleColorView)
        stackView.addArrangedSubview(colorSelectionView)
        stackView.addArrangedSubview(mainLocationButton)
        stackView.addArrangedSubview(textContentView)
        view.addSubview(saveMarkView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(-58)
        }
        
        saveMarkView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
    
    private func setNavigationBar() {
        title = "기록 쓰기"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureScheduleTitleColorView() {
        if let schedule = schedule {
            scheduleTitleColorView.configure(with: schedule.title, color: schedule.color, isColorSelection: false)
        }
        scheduleTitleColorView.delegate = self
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardWillChange(notification, isShowing: false)
    }
    
    private func keyboardWillChange(_ notification: Notification, isShowing: Bool) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        stackView.snp.remakeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(isShowing ? -keyboardHeight : -58)
        }
        
        saveMarkView.snp.remakeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view).offset(isShowing ? -keyboardHeight : -34)
            $0.height.equalTo(48)
        }
        
        saveMarkView.configure(true)
        view.layoutIfNeeded()
    }
}

extension WriteMarkViewController: ColorSelectionButtonDelegate {
    func colorSelectionButtonTapped(_ isSelected: Bool) {
        colorSelectionView.snp.remakeConstraints {
            $0.height.equalTo(isSelected ? 186 : 0)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        if let schedule = schedule {
            scheduleTitleColorView.configure(with: schedule.title, color: schedule.color, isColorSelection: isSelected)
        }
    }
}
