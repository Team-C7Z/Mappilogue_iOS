//
//  ImagePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos
import PhotosUI

class ImagePickerViewController: BaseViewController {
    var allPhotos = PHFetchResult<PHAsset>()
    var authStatus: PHAuthorizationStatus?
    var favoritePhotosAlbum =  PHFetchResult<PHAsset>()
    var userCollections = PHFetchResult<PHAssetCollection>()
    var currentAlbum = PHFetchResult<PHAsset>()
    let allPhotosOptions = PHFetchOptions()
    var selectedAssets: [PHAsset] = []
    
    var isPhotoDirectory: Bool = false
    var onCompletion: (([PHAsset]) -> Void)?
    
    private let navigationBar = CustomNavigationBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let limitedPhotoSelectionView = LimitedPhotoSelectionView()
    private let photoDirectoryView = PhotoDirectoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButtonTapped()
        photoDirectoryPickerButtonTapped()
        completionButtonTapped()
        
        PHPhotoLibrary.shared().register(self)
        
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
   
        getFavoritePhotos()
        
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
        
        if authStatus == .authorized {
            limitedPhotoSelectionView.isHidden = true
        }
        
        photoDirectoryView.configure(authStatus, allPhotos: allPhotos, favoritePhotosAlbum: favoritePhotosAlbum, userCollections: userCollections)
        
        currentAlbum = allPhotos
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        limitedPhotoSelectionView.backgroundColor = .colorF9F8F7
        
        limitedPhotoSelectionView.addImagesButton.addTarget(self, action: #selector(addImagesButtonTapped), for: .touchUpInside)
        limitedPhotoSelectionView.setPermissionButton.addTarget(self, action: #selector(setPermissionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(navigationBar)
        view.addSubview(collectionView)
        view.addSubview(limitedPhotoSelectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).offset(authStatus == .limited ? -142 : 0)
        }
        
        limitedPhotoSelectionView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view)
            $0.height.equalTo(142)
        }
    }
    
    private func dismissButtonTapped() {
        navigationBar.onDismiss = {
            self.dismiss(animated: true)
        }
    }
    
    private func photoDirectoryPickerButtonTapped() {
        navigationBar.onPhotoDirectoryPickerButtonTapped = {
            self.togglePhotoViewMode()
        }
    }
    
    private func togglePhotoViewMode() {
        isPhotoDirectory = !isPhotoDirectory
        if isPhotoDirectory {
            addPhotoDirectoryView()
        } else {
            removePhotoDirectoryView()
        }
    }
    
    private func completionButtonTapped() {
        navigationBar.onCompletion = {
            self.dismiss(animated: true) {
                self.onCompletion?(self.selectedAssets)
            }
        }
    }
    
    private func getFavoritePhotos() {
        let favoriteOptios = PHFetchOptions()
        favoriteOptios.predicate = NSPredicate(format: "favorite == %@", NSNumber(value: true))
        
        let smartAlbums = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumFavorites,
            options: nil)
        
        if let favoritePhotosAlbum = smartAlbums.firstObject {
            self.favoritePhotosAlbum = PHAsset.fetchAssets(in: favoritePhotosAlbum, options: favoriteOptios)
        }
    }
    
    @objc private func addImagesButtonTapped() {
        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
    }
    
    @objc private func setPermissionButtonTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func addPhotoDirectoryView() {
        photoDirectoryView.configure(authStatus, allPhotos: allPhotos, favoritePhotosAlbum: favoritePhotosAlbum, userCollections: userCollections)
        
        view.addSubview(photoDirectoryView)
        
        photoDirectoryView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view)
        }
        
        photoDirectoryView.onDirectorySelection = { album in
            self.selectDirectory(album)
        }
    }
    
    private func removePhotoDirectoryView() {
        photoDirectoryView.removeFromSuperview()
    }
}

extension ImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.registerId, for: indexPath) as? ImagePickerCell else { return UICollectionViewCell() }
        
        let asset = currentAlbum[indexPath.row]
        cell.configure(asset)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 10) / 3
        return CGSize(width: size, height: size)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = currentAlbum[indexPath.row]
        if let index = selectedAssets.firstIndex(where: { $0 == asset}) {
            selectedAssets.remove(at: index)
        } else {
            selectedAssets.append(asset)
        }
    }
}

extension ImagePickerViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: allPhotos) else { return }
        allPhotos = changes.fetchResultAfterChanges
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ImagePickerViewController {
    func selectDirectory(_ album: PHFetchResult<PHAsset>) {
        removePhotoDirectoryView()
        currentAlbum = album
        collectionView.reloadData()
    }
}