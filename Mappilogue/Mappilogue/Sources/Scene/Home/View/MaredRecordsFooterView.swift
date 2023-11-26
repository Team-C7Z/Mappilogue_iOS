//
//  MaredRecordsFooterView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/22.
//

import UIKit

class MaredRecordsFooterView: BaseTableViewHeaderFooterView {
    static let registerId = "\(MaredRecordsFooterView.self)"
    
    var onAddSchedule: (() -> Void)?
    var onMarkedRecord: (() -> Void)?
    var onAddRecord: (() -> Void)?
    
    private let addScheduleButton = AddButton(text: "일정 추가하기", backgroundColor: .color1C1C1C)
    
    let dummyMarkedData = dummyMarkedRecordData(markedRecordCount: 1         )
    let limitedMarkedRecordsCount = 3
    
    private var markedRecordsLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MarkedRecordCell.self, forCellWithReuseIdentifier: MarkedRecordCell.registerId)
        collectionView.register(AddMarkedRecordCell.self, forCellWithReuseIdentifier: AddMarkedRecordCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
        
        markedRecordsLabel.text = "마크한 기록"
        markedRecordsLabel.font = .title01
        markedRecordsLabel.textColor = .color1C1C1C
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(addScheduleButton)
        contentView.addSubview(markedRecordsLabel)
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addScheduleButton.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(contentView)
            $0.height.equalTo(53)
        }
        
        markedRecordsLabel.snp.makeConstraints {
            $0.top.equalTo(addScheduleButton.snp.bottom).offset(24)
            $0.leading.equalTo(contentView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(markedRecordsLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(221)
        }
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        onAddSchedule?()
    }
}

extension MaredRecordsFooterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(dummyMarkedData.count, limitedMarkedRecordsCount) + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < min(dummyMarkedData.count, limitedMarkedRecordsCount) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarkedRecordCell.registerId, for: indexPath) as? MarkedRecordCell else { return UICollectionViewCell() }
            
            let record = dummyMarkedData[indexPath.row]
            cell.configure(record)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMarkedRecordCell.registerId, for: indexPath) as? AddMarkedRecordCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 211)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < min(dummyMarkedData.count, limitedMarkedRecordsCount) {
            onMarkedRecord?()
        } else {
            onAddRecord?()
        }
    }
}
