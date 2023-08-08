//
//  NotificationSettingsViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingsViewController: BaseViewController {
    let notificationInfo = notificationInfoData()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(NotificationSettingCell.self, forCellWithReuseIdentifier: NotificationSettingCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("My", backButtonAction: #selector(backButtonTapped))
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
}

extension NotificationSettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationSettingCell.registerId, for: indexPath) as? NotificationSettingCell else { return UICollectionViewCell() }
        let title = indexPath.section == 0 ? "전체 알림" : notificationInfo[indexPath.row].title
        let isSwitch = indexPath.section == 0 ? false : notificationInfo[indexPath.row].isSwitch
        let isLast = indexPath.section == 0 || indexPath.row == notificationInfo.count-1
        
        cell.configure(title: title, isSwitch: isSwitch, isLast: isLast)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 49)
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

    }
}
