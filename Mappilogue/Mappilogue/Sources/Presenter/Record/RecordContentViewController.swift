//
//  RecordContentViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit

class RecordContentViewController: BaseViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let recordContentHeaderView = RecordContentHeaderView()
    private let recordContentView = ContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndItems(imageName: "menu", action: #selector(menuButtonTapped), isLeft: false)
        setNavigationTitleAndBackButton("나의 기록", backButtonAction: #selector(backButtonTapped))
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        recordContentView.contentView.text = " "
        recordContentView.contentView.isEditable = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(recordContentHeaderView)
        stackView.addArrangedSubview(recordContentView)
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
        
    }
    
    @objc func menuButtonTapped() {
        let editViewController = EditViewController()
        editViewController.modalPresentationStyle = .overFullScreen
        editViewController.configure(modifyTitle: "수정하기",
                                             deleteTitle: "삭제하기",
                                             alert: Alert(titleText: "이 기록을 삭제할까요?",
                                                          messageText: nil,
                                                          cancelText: "취소",
                                                          doneText: "삭제",
                                                          buttonColor: .colorF14C4C,
                                                          alertHeight: 140))
        editViewController.onModify = { }
        editViewController.onDelete = { }
        present(editViewController, animated: false)
    }

}
