//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {
    let dummyData = generateDummyScheduleData(schduleCount: 1)
    
    var scheduleType: ScheduleType = .today
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(EmptyScheduleCell.self, forCellWithReuseIdentifier: EmptyScheduleCell.registerId)
        collectionView.register(AddScheduleButtonCell.self, forCellWithReuseIdentifier: AddScheduleButtonCell.registerId)
        collectionView.register(TodayScheduleCell.self, forCellWithReuseIdentifier: TodayScheduleCell.registerId)
        collectionView.register(TodayScheduleInfoCell.self, forCellWithReuseIdentifier: TodayScheduleInfoCell.registerId)
        collectionView.register(AddLocationButtonCell.self, forCellWithReuseIdentifier: AddLocationButtonCell.registerId)
        collectionView.register(ScheduleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ScheduleHeaderView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func setupProperty() {
        super.setupProperty()
        
        setupNavigationBar()
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
    
    func setupNavigationBar() {
        self.navigationItem.title = ""
        
        let logoImage = UIImage(named: "home_logo")?.withRenderingMode(.alwaysOriginal)
        let buttonItem = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = buttonItem
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dummyData.count == 0 ? 2 : dummyData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dummyData.count == 0 || section == dummyData.count {
            return 1
        }
        return dummyData[section].location.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dummyData.count == 0 {
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyScheduleCell.registerId, for: indexPath) as? EmptyScheduleCell else { return UICollectionViewCell() }
                return cell
                
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UICollectionViewCell() }
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddLocationButtonCell.registerId, for: indexPath) as? AddLocationButtonCell else { return UICollectionViewCell() }
            return cell
            
        } else if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UICollectionViewCell() }
            
            let title = dummyData[indexPath.section].title
            let backgroundColor = dummyData[indexPath.section].color
            
            cell.configure(with: title, backgroundColor: backgroundColor)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UICollectionViewCell() }
            
            let index = "\(indexPath.row)"
            let location = dummyData[indexPath.section].location[indexPath.row - 1]
            let time = dummyData[indexPath.section].time[indexPath.row - 1]
            
            cell.configure(with: index, location: location, time: time)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let topInset: CGFloat = (section == 0) ? 18 : 10
        return UIEdgeInsets(top: topInset, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        
        if dummyData.count == 0 {
            let height: CGFloat = (indexPath.section == 0) ? 130 : 53
            return CGSize(width: width, height: height)
            
        } else if indexPath.row == 0 {
            let height: CGFloat = 38
            return CGSize(width: width, height: height)
            
        } else if indexPath.section == dummyData.count {
            let height: CGFloat = 53
            return CGSize(width: width, height: height)
            
        } else {
            let height: CGFloat = 50
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ScheduleHeaderView.registerId, for: indexPath) as? ScheduleHeaderView else { return UICollectionReusableView() }
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat = (section == 0) ? 30 : 0
        return CGSize(width: collectionView.bounds.width, height: headerHeight)
    }
}

extension HomeViewController: ScheduleTypeDelegate {
    func scheduleButtonTapped(scheduleType: ScheduleType) {
        
    }
}
