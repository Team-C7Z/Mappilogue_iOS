//
//  PhotoDirectoryView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/20.
//

import UIKit
import Photos

class PhotoDirectoryView: BaseView {
    var authStatus: PHAuthorizationStatus?
    var recentItemDirectoryPhotos = PHFetchResult<PHAsset>()
    let photosOptions = PHFetchOptions()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(PhotoDirectoryCell.self, forCellWithReuseIdentifier: PhotoDirectoryCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func setupProperty() {
        super.setupProperty()
    
        collectionView.reloadData()
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
    
}

extension PhotoDirectoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return authStatus == .limited ? 1 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoDirectoryCell.registerId, for: indexPath) as? PhotoDirectoryCell else { return UICollectionViewCell() }
        cell.configure(recentItemDirectoryPhotos.firstObject, title: "최근 항목", count: recentItemDirectoryPhotos.count)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-32, height: 72)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
