//
//  MarkedRecordsCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/02.
//

import UIKit

class MarkedRecordsCell: BaseTableViewCell {
    static let registerId = "\(MarkedRecordsCell.self)"
    
    let dummyMarkedData = dummyMarkedRecordData(markedRecordCount: 4)
    
    private var markedRecordsLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MarkedRecordCell.self, forCellWithReuseIdentifier: MarkedRecordCell.registerId)
        collectionView.register(AddMarkedRecordCell.self, forCellWithReuseIdentifier: AddMarkedRecordCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    override func setupProperty() {
        super.setupProperty()

        markedRecordsLabel.text = "마크한 기록"
        markedRecordsLabel.textColor = .color1C1C1C
        markedRecordsLabel.font = .pretendard(.medium, size: 20)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markedRecordsLabel)
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        markedRecordsLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(markedRecordsLabel.snp.bottom).offset(18)
            $0.leading.bottom.trailing.equalTo(contentView)
        }
    }
}

extension MarkedRecordsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dummyMarkedData.isEmpty {
            return 1
        } else if dummyMarkedData.count <= 3 {
            return dummyMarkedData.count + 1
        } else {
            return 4
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dummyMarkedData.count <= 3 {
            if dummyMarkedData.count > indexPath.row {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarkedRecordCell.registerId, for: indexPath) as? MarkedRecordCell else { return UICollectionViewCell() }
                
                let image = "markedRecordTest"
                let date = dummyMarkedData[indexPath.row].date
                let location = dummyMarkedData[indexPath.row].location
                cell.configure(image: image, date: date, location: location, color: dummyMarkedData[indexPath.row].color)
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMarkedRecordCell.registerId, for: indexPath) as? AddMarkedRecordCell else { return UICollectionViewCell() }
                return cell
            }
        } else {
            if 3 > indexPath.row {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarkedRecordCell.registerId, for: indexPath) as? MarkedRecordCell else { return UICollectionViewCell() }
                
                let image = "markedRecordTest"
                let date = dummyMarkedData[indexPath.row].date
                let location = dummyMarkedData[indexPath.row].location
                cell.configure(image: image, date: date, location: location, color: dummyMarkedData[indexPath.row].color)
                
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMarkedRecordCell.registerId, for: indexPath) as? AddMarkedRecordCell else { return UICollectionViewCell() }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 176, height: 211)
    }
}
