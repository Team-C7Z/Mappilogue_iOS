//
//  ScheduleDateHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/10.
//

import UIKit

class ScheduleDateFooterView: BaseCollectionReusableView {
    static let registerId = "\(ScheduleDateFooterView.self)"
    
    var onDateTapped: ((Int) -> Void)?
    
    private var locations: [Area] = []
    private var selectedDateIndex = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduleDateCell.self, forCellWithReuseIdentifier: ScheduleDateCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func setupProperty() {
        super.setupProperty()

    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configure(_ locations: [Area]) {
        self.locations = locations
    }
}

extension ScheduleDateFooterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleDateCell.registerId, for: indexPath) as? ScheduleDateCell else { return ScheduleDateCell() }
        let date = locations[indexPath.row].date
        let isSelected = selectedDateIndex == indexPath.row
        cell.configure(date, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 99, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDateIndex = indexPath.row
        onDateTapped?(selectedDateIndex)
        
        collectionView.reloadData()
    }
}
