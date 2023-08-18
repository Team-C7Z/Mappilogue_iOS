//
//  BottomSheetViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class BottomSheetViewController: BaseViewController {
    var dummyRecord: [Record] = []
    var emptyCellHeight: CGFloat = 196
    
    private let barImage = UIImageView()
    private let sortView = SortView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(EmptyRecordCell.self, forCellWithReuseIdentifier: EmptyRecordCell.registerId)
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: RecordCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .colorF9F8F7
        
        barImage.image = UIImage(named: "bottomSheetBar")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(barImage)
        view.addSubview(sortView)
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        barImage.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view).offset(12)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        sortView.snp.makeConstraints {
            $0.top.equalTo(view).offset(24)
            $0.leading.trailing.equalTo(view)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom).offset(12)
            $0.width.height.equalTo(view)
        }
    }
}

extension BottomSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyRecord.isEmpty ? 1 : dummyRecord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if dummyRecord.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyRecordCell.registerId, for: indexPath) as? EmptyRecordCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.registerId, for: indexPath) as? RecordCell else { return UICollectionViewCell() }
            
            let record = dummyRecord[indexPath.row]
            cell.configure(with: record)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: dummyRecord.isEmpty ? emptyCellHeight - 56 : 64)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
