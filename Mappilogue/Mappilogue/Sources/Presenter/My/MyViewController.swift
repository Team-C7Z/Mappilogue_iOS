//
//  MyViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

struct MyInfo {
    var image: String
    var title: String
}

class MyViewController: NavigationBarViewController {
    var myInfoData: [[MyInfo]] = [
        [
            MyInfo(image: "my_notification", title: "알림 설정"),
            MyInfo(image: "my_terms", title: "이용약관"),
            MyInfo(image: "my_inquiry", title: "문의하기")
        ],
        [
            MyInfo(image: "my_logout", title: "로그아웃"),
            MyInfo(image: "my_withdrawal", title: "탈퇴하기")
        ]
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.registerId)
        collectionView.register(VersionCell.self, forCellWithReuseIdentifier: VersionCell.registerId)
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func checkWithdrawalStatus(_ notification: Notification) {
        showWithdrawalConfirmationAlert()
    }
    
    @objc func showWithdrawalConfirmationAlert() {
        let withdrawalCompletedAlertViewController = WithdrawalCompletedAlertViewController()
        withdrawalCompletedAlertViewController.modalPresentationStyle = .overCurrentContext
        withdrawalCompletedAlertViewController.onDoneTapped = {
            print("로그인 페이지로 이동")
        }
        present(withdrawalCompletedAlertViewController, animated: false)
    }
}

extension MyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0...1:
            return 1
        case 2:
            return 3
        case 3:
            return 2
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = configureProfileCell(for: indexPath, in: collectionView)
            return cell
        case 1:
            let cell = configureVersionCell(for: indexPath, in: collectionView)
            return cell
        default:
            let cell = configureMyCell(for: indexPath, in: collectionView)
            return cell
        }
    }
    
    private func configureProfileCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.registerId, for: indexPath) as? ProfileCell else { return UICollectionViewCell() }
        return cell
    }
    
    private func configureVersionCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VersionCell.registerId, for: indexPath) as? VersionCell else { return UICollectionViewCell() }
        return cell
    }
    
    private func configureMyCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.registerId, for: indexPath) as? MyCell else { return UICollectionViewCell() }
        let myInfo = myInfoData[indexPath.section-2][indexPath.row]
        let isLast = indexPath.row == myInfoData[indexPath.section-2].count-1
        cell.configure(myInfo: myInfo, isLast: isLast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: indexPath.section == 0 ? 72 : 48)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            showEditProfileViewController()
        case 2:
            didSelect2Section(indexPath)
        case 3:
            didSelect3Section(indexPath)
        default:
            break
        }
    }
    
    private func showEditProfileViewController() {
        let editProfileViewController = EditProfileViewController()
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    private func didSelect2Section(_ indexPath: IndexPath) {
        if indexPath.row == 0 {
            let notificationSettingViewController = NotificationSettingViewController()
            navigationController?.pushViewController(notificationSettingViewController, animated: true)
        } else if indexPath.row == 2 {
            let inquiryViewController = InquiryViewController()
            navigationController?.pushViewController(inquiryViewController, animated: true)
        }
    }
    
    private func didSelect3Section(_ indexPath: IndexPath) {
        if indexPath.row == 0 {
            presentLogoutAlert()
        } else if indexPath.row == 1 {
            presentWithdrawalAlert()
        }
    }
    
    private func presentLogoutAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "로그아웃 할까요?",
                          messageText: nil,
                          cancelText: "취소",
                          doneText: "확인",
                          buttonColor: .color2EBD3D,
                          alertHeight: 140)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            print("로그아웃")
        }
        present(alertViewController, animated: false)
     }
    
    private func presentWithdrawalAlert() {
        let withdrawalAlertViewController = WithdrawalAlertViewController()
        withdrawalAlertViewController.modalPresentationStyle = .overCurrentContext
        withdrawalAlertViewController.onDoneTapped = {
            let withdrawalViewController = WithdrawalViewController()
            self.navigationController?.pushViewController(withdrawalViewController, animated: true)
        }
        present(withdrawalAlertViewController, animated: false)
    }
}
