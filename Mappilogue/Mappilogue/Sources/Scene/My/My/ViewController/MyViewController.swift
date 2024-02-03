//
//  MyViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import KakaoSDKUser
import MappilogueKit

class MyViewController: NavigationBarViewController {
    weak var coordinator: MyCoordinator?
    var viewModel = MyViewModel()
    
    var profile: ProfileDTO?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.backgroundColor = .grayF9F8F7
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
        
        getProfile()
    }

    override func setupProperty() {
        super.setupProperty()
        
        setNotificationBar(title: "MY")
        
        notificationBar.onNotificationButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            coordinator?.showNotificationViewController()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func getProfile() {
        viewModel.getProfile()
        
        viewModel.$profileResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                self.profile = result
                self.collectionView.reloadData()
            })
            .store(in: &viewModel.cancellables)
        
    }
    
    @objc func checkWithdrawalStatus(_ notification: Notification) {
        presentWithdrawalConfirmationAlert()
    }
    
    @objc func presentWithdrawalConfirmationAlert() {
        coordinator?.showWithdrawalCompletedAlertViewController()
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
        cell.configure(profile)
        return cell
    }
    
    private func configureVersionCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VersionCell.registerId, for: indexPath) as? VersionCell else { return UICollectionViewCell() }
        cell.onVersionUpdate = { [weak self] in
            guard let self = self else { return }
            
            openAppStore("")
        }
        return cell
    }
    
    private func configureMyCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.registerId, for: indexPath) as? MyCell else { return UICollectionViewCell() }
        let myInfo = viewModel.myInfoData[indexPath.section-2][indexPath.row]
        let isLast = indexPath.row == viewModel.myInfoData[indexPath.section-2].count-1
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
            coordinator?.showEditProfileViewController(profile)
        case 2:
            if indexPath.row == 0 {
                coordinator?.showNotificationSettingViewController()
            } else if indexPath.row == 1 {
                coordinator?.showTermsOfUserViewController()
            } else if indexPath.row == 2 {
                coordinator?.showInquiryViewController()
            }
        case 3:
            if indexPath.row == 0 {
                presentLogoutAlert()
            } else if indexPath.row == 1 {
                presentWithdrawalAlert()
            }
        default:
            break
        }
    }
    
    private func openAppStore(_ appId: String) {
        let url =  "itms-apps://itunes.apple.com/app/" + appId
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func presentLogoutAlert() {
        let alert = Alert(titleText: "로그아웃 할까요?",
                          messageText: nil,
                          cancelText: "취소",
                          doneText: "확인",
                          buttonColor: .green2EBD3D,
                          alertHeight: 140)
//        alertViewController.onDoneTapped = {
//            self.logout()
//        }
        coordinator?.showLogoutAlert(alert: alert)
     }
    
    private func presentWithdrawalAlert() {
        coordinator?.showWithdrawalAlertViewController()
    }
    
    func logout() {
        viewModel.logout()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { _ in
                self.clearAuthUserDefaults()
                self.presentLoginViewController()
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func clearAuthUserDefaults() {
        AuthUserDefaults.accessToken = nil
        AuthUserDefaults.refreshToken = nil
    }
    
    func presentLoginViewController() {
        coordinator?.showLoginViewController()
    }
}
