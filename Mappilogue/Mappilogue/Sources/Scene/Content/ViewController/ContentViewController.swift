//
//  ContentViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit
import MappilogueKit

class ContentViewController: NavigationBarViewController {
    weak var coordinator: ContentCoordinator?
    var schedule = Schedule2222()
    var isNewWrite: Bool = false
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let recordContentHeaderView = MyRecordContentHeaderView()
    private let myRecordContentImageView = MyRecordContentImageView()
    private let contentTextView = ContentTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myRecordContentImageView.onImageTapped = { imageName in
            self.presentImageDetailViewController(imageName)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopMenuBar(title: "나의 기록")
        popMenuBar.onMenuButtonTapped = {
            self.menuButtonTapped()
        }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        recordContentHeaderView.configure(schedule)
        if let images = schedule.image {
            myRecordContentImageView.configure(images, size: view.frame.width - 32)
        }
        contentTextView.configure(schedule.content ?? "", width: view.frame.width - 32)
        contentTextView.stackViewHeightUpdated = {
            self.stackView.layoutIfNeeded()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(recordContentHeaderView)
        stackView.addArrangedSubview(myRecordContentImageView)
        stackView.addArrangedSubview(contentTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalToSuperview()
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
//        editViewController.onModify = { self.modifyRecord() }
//        editViewController.onDelete = { self.deleteRecord() }
        let alert = Alert(titleText: "이 기록을 삭제할까요?",
                          messageText: nil,
                          cancelText: "취소",
                          doneText: "삭제",
                          buttonColor: .redF14C4C,
                          alertHeight: 140)
        coordinator?.showEditBottomSheetViewController(modifyTitle: "수정하기", deleteTitle: "삭제하기", alert: alert)
    }
    
    private func modifyRecord() {
        coordinator?.showWriteRecordViewController()
    }
    
    private func deleteRecord() {
        if isNewWrite {
            if let viewControllerToPopTo = navigationController?.viewControllers.first(where: { $0 is WriteRecordListRecordViewController }) {
                
                navigationController?.popToViewController(viewControllerToPopTo, animated: true)
            }
        } else {
            coordinator?.popViewController()
        }
    }
    
    private func presentImageDetailViewController(_ imageName: String) {
        coordinator?.showImageDetailViewController(imageName: imageName)
    }
}
