//
//  MarkedRecordsCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/02.
//

import UIKit

class MarkedRecordsCell: BaseTableViewCell {
    static let registerId = "\(MarkedRecordsCell.self)"
    
    private var markedRecordsLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMarkedRecordCell.registerId, for: indexPath) as? AddMarkedRecordCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 176, height: 211)
    }
}
