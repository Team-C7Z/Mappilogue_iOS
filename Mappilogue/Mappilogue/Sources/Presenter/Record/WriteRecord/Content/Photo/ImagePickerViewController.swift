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
    
    var isProfile: Bool = false
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
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { permission in
            if permission {
                print("Camera: 권한 허용")
                DispatchQueue.main.async {
                    self.presentCameraViewController()
                }
            } else {
                print("Camera: 권한 거부")
                DispatchQueue.main.async {
                    self.presentCameraPermissionAlert()
                }
            }
        }
    }
    
    func presentCameraPermissionAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "카메라 접근 권한을 허용해 주세요",
                          messageText: "카메라 접근 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                          cancelText: "닫기",
                          doneText: "설정으로 이동",
                          buttonColor: .color2EBD3D,
                          alertHeight: 182)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        self.present(alertViewController, animated: false)
    }
    
    private func presentCameraViewController() {
        let cameraViewController = CameraViewController()
        let navigationController = UINavigationController(rootViewController: cameraViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension ImagePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbum.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.registerId, for: indexPath) as? ImagePickerCell else { return UICollectionViewCell() }
        
        if indexPath.row == 0 {
            cell.configure(nil, isCamera: true, isSelected: false)
        } else {
            let asset = currentAlbum[indexPath.row - 1]
            let isSelected = selectedAssets.contains(asset)
            cell.configure(asset, isCamera: false, isSelected: isSelected)
        }
        
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
        if indexPath.row == 0 {
            checkCameraPermission()
        } else {
            let asset = currentAlbum[indexPath.row - 1]
            
            if isProfile {
                selectedAssets = [asset]
                
            } else {
                if let index = selectedAssets.firstIndex(where: { $0 == asset}) {
                    selectedAssets.remove(at: index)
                } else {
                    selectedAssets.append(asset)
                }
            }
            
            collectionView.reloadItems(at: [indexPath])
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
