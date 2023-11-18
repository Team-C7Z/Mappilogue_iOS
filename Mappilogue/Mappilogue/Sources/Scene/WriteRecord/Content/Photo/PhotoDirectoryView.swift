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
    var allPhotos = PHFetchResult<PHAsset>()
    var favoritePhotosAlbum = PHFetchResult<PHAsset>()
    var userCollections = PHFetchResult<PHAssetCollection>()
    let photosOptions = PHFetchOptions()
    
    var onDirectorySelection: ((PHFetchResult<PHAsset>) -> Void)?
    
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
        
       // collectionView.reloadData()
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
    
    func configure(_ authStatus: PHAuthorizationStatus?, allPhotos: PHFetchResult<PHAsset>, favoritePhotosAlbum: PHFetchResult<PHAsset>, userCollections: PHFetchResult<PHAssetCollection>) {
        self.authStatus = authStatus
        self.allPhotos = allPhotos
        self.favoritePhotosAlbum = favoritePhotosAlbum
        self.userCollections = userCollections
        collectionView.reloadData()
    }
    
}

extension PhotoDirectoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return authStatus == .limited ? 1 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return userCollections.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoDirectoryCell.registerId, for: indexPath) as? PhotoDirectoryCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.configure(allPhotos.firstObject, title: "최근 항목", count: allPhotos.count)
        case 1:
            cell.configure(favoritePhotosAlbum.firstObject, title: "즐겨찾는 항목", count: favoritePhotosAlbum.count)
        default:
            let album = userCollections[indexPath.row]
            let assets = PHAsset.fetchAssets(in: album, options: nil)
            let title = album.localizedTitle ?? ""
            cell.configure(assets.firstObject, title: title, count: assets.count)
        }
      
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            onDirectorySelection?(allPhotos)
        case 1:
            onDirectorySelection?(favoritePhotosAlbum)
        case 2:
            let album = userCollections[indexPath.row]
            let assets = PHAsset.fetchAssets(in: album, options: nil)
            onDirectorySelection?(assets)
        default:
            break
        }
    }
}
