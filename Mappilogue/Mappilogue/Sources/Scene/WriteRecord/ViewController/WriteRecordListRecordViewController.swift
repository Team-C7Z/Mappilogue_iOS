//
//  WriteRecordListRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class WriteRecordListRecordViewController: NavigationBarViewController {
    weak var coordinator: WriteRecordListCoordinator?
    var dummyData = dummyScheduleData()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(SelectScheduleCell.self, forCellWithReuseIdentifier: SelectScheduleCell.registerId)
        collectionView.register(DateHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DateHeaderView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let newWriteButton = NewWriteButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dummyData = dummyData.sorted { $0.year > $1.year }.sorted { $0.month > $1.month }.sorted {$0.day > $1.day}
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "기록 쓰기")
        
        popBar.onPopButtonTapped = {
            self.coordinator?.popViewController()
        }
        
        newWriteButton.addTarget(self, action: #selector(newWriteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
        view.addSubview(newWriteButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(newWriteButton.snp.top).offset(-12)
        }
        
        newWriteButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }
    }
    
    func presentToWriteRecordViewController(_ indexPath: IndexPath?) {
        var schedule = Schedule2222()
        
        if let indexPath = indexPath {
            schedule =  dummyData[indexPath.section].schedules[indexPath.row]
        }
        coordinator?.showWriteRecordViewController(schedule: schedule)
    }
    
    @objc private func newWriteButtonTapped() {
        presentToWriteRecordViewController(nil)
    }
}

extension WriteRecordListRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dummyData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData[section].schedules.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectScheduleCell.registerId, for: indexPath) as? SelectScheduleCell else { return UICollectionViewCell() }
        
        let schedule = dummyData[indexPath.section].schedules[indexPath.row]
    //    cell.configure(with: schedule)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 52)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DateHeaderView.registerId, for: indexPath) as? DateHeaderView else { return UICollectionReusableView() }
        
        let month = dummyData[indexPath.section].month
        let day = dummyData[indexPath.section].day
        headerView.configure(month: month, day: day)
        
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
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
        presentToWriteRecordViewController(indexPath)
    }
}
