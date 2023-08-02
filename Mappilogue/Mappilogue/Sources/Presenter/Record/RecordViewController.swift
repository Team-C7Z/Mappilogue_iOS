//
//  RecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import NMapsMap

class RecordViewController: NavigationBarViewController {
    let dummyCategory = dummyCategoryData()
    let dummyRecord = dummyRecordData()
    
    var delegate: EmptyRecordDelegate?
    
    let locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay?
    
    let minHeight: CGFloat = 44
    let midHeight: CGFloat = 196
    var maxHeight: CGFloat = 0
    var bottomSheetHeight: CGFloat = 0
    
    let mapView = NMFMapView()
    let searchTextField = SearchTextField()
    let searchButton = UIButton()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.registerId)
        collectionView.register(AddCategoryCell.self, forCellWithReuseIdentifier: AddCategoryCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    let currentLocationButton = UIButton()
    let myRecordButton = MyRecordButton()
    let writeRecordButton = WriteRecordButton()
    let containerView = UIView()
    let bottomSheetViewController = BottomSheetViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationOverlay = mapView.locationOverlay
        setLocationManager()
        checkUserCurrentLocationAuthorization()
        setMarker()
        setBottomSheetViewController()
        setPanGesture()
    }

    override func setupProperty() {
        super.setupProperty()
        
        setMapView()
        setBottomSheetHeight()
     
        searchTextField.delegate = self
        searchTextField.layer.applyShadow()
        setSearchTextFieldTapGestue()
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        
        currentLocationButton.setImage(UIImage(named: "moveCurrentLocation"), for: .normal)
        currentLocationButton.layer.applyShadow()
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        
        myRecordButton.addTarget(self, action: #selector(myRecordButtonTapped), for: .touchUpInside)
        writeRecordButton.addTarget(self, action: #selector(writeRecordButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(mapView)
        mapView.addSubview(searchTextField)
        searchTextField.addSubview(searchButton)
        mapView.addSubview(collectionView)
        view.addSubview(currentLocationButton)
        view.addSubview(myRecordButton)
        view.addSubview(writeRecordButton)
        view.addSubview(containerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(mapView).offset(12)
            $0.leading.equalTo(mapView).offset(16)
            $0.trailing.equalTo(mapView).offset(-16)
            $0.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(searchTextField).offset(-7)
            $0.centerY.equalTo(searchTextField)
            $0.width.height.equalTo(28)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(8)
            $0.leading.equalTo(mapView)
            $0.trailing.equalTo(mapView)
            $0.height.equalTo(32)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(containerView.snp.top).offset(-16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(48)
        }
        
        myRecordButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(writeRecordButton.snp.top).offset(-16)
        }
        
        writeRecordButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(containerView.snp.top).offset(-16)
        }
  
        containerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(mapView)
            $0.height.equalTo(bottomSheetHeight)
        }
    }
    
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startLocationManager() {
        locationManager.startUpdatingLocation()
    }
    
    private func setMapView() {
        mapView.logoInteractionEnabled = false
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
        mapView.positionMode = .compass
        mapView.minZoomLevel = 10.0
        mapView.maxZoomLevel = 18.0
    }
    
    private func setLocationOverlayIcon(latitude: Double, longitude: Double) {
        guard let locationOverlay = locationOverlay else { return }
        locationOverlay.hidden = false
        locationOverlay.location = NMGLatLng(lat: latitude, lng: longitude)
        locationOverlay.icon = NMFOverlayImage(name: "currentLocation")
        locationOverlay.iconWidth = 20
        locationOverlay.iconHeight = 20
    }
    
    private func setMarker() {
        for record in dummyRecord {
            guard let lat = record.lat, let lng = record.lng else { return }
            let markerView = createMarkerView(record: record)
            let marker = createMarker(markerView: markerView, lat: lat, lng: lng)
            
            marker.mapView = mapView
        }
    }
    
    private func createMarkerView(record: Record) -> MarkerView {
        let markerView = MarkerView(frame: CGRect(x: 0, y: 0, width: 48, height: 64))
        markerView.configure(image: "", color: record.color)
        
        return markerView
    }
    
    private func createMarker(markerView: MarkerView, lat: Double, lng: Double) -> NMFMarker {
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(image: markerView.asImage())
        marker.position = NMGLatLng(lat: lat, lng: lng)
        
        return marker
    }
    
    @objc private func searchTextFieldTapped() {
        let searchViewController = SearchViewController()
        searchViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    private func setSearchTextFieldTapGestue() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchTextFieldTapped))
        searchTextField.addGestureRecognizer(tap)
    }
    
    @objc private func currentLocationButtonTapped(_ sender: UIButton) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 37.49794, lng: locationManager.location?.coordinate.longitude ?? 127.02759))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    @objc private func myRecordButtonTapped(_ sender: UIButton) {
        let myRecordViewController = MyRecordViewController()
        myRecordViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(myRecordViewController, animated: true)
    }
    
    @objc private func writeRecordButtonTapped() {
        let selectWriteRecordViewController = SelectWriteRecordViewController()
        selectWriteRecordViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(selectWriteRecordViewController, animated: true)
    }
    
    private func setBottomSheetViewController() {
        addChild(bottomSheetViewController)
        bottomSheetViewController.view.frame = containerView.bounds
        containerView.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.didMove(toParent: self)
    }
    
    private func setBottomSheetHeight() {
        maxHeight = view.frame.height - 200

        if dummyRecord.isEmpty {
            bottomSheetHeight = minHeight
        } else {
            bottomSheetHeight = midHeight
        }
    }
    
    private func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        containerView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: containerView)
        let newContainerHeight = containerView.frame.height - translation.y
        let clampedHeight = min(max(newContainerHeight, minHeight), maxHeight)
        
        containerView.snp.updateConstraints { make in
            make.height.equalTo(clampedHeight)
        }
        
        var nearestHeight: CGFloat = minHeight
        
        if clampedHeight <= (midHeight + minHeight) / 2 {
            nearestHeight = minHeight
        } else if clampedHeight <= (maxHeight) / 2 {
            nearestHeight = midHeight
        } else {
            nearestHeight = maxHeight
        }
        
        setButtonsVisibility(isHidden: clampedHeight > view.frame.height / 2, height: clampedHeight)
        
        if gesture.state == .ended || gesture.state == .cancelled {
            containerView.snp.updateConstraints { make in
                make.height.equalTo(nearestHeight)
            }
            
            updateBottomSheet(nearestHeight)
            setButtonsVisibility(isHidden: nearestHeight == maxHeight, height: nearestHeight)
            bottomSheetViewController.collectionView.reloadData()

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        gesture.setTranslation(.zero, in: containerView)
    }
    
    private func setButtonsVisibility(isHidden: Bool, height clampedHeight: CGFloat) {
        currentLocationButton.isHidden = isHidden
        myRecordButton.isHidden = isHidden
        writeRecordButton.isHidden = isHidden
    }
    
    private func updateBottomSheet(_ nearestHeight: CGFloat) {
        if nearestHeight == maxHeight {
            bottomSheetViewController.emptyCellHeight = view.frame.height - 200
        } else {
            bottomSheetViewController.emptyCellHeight = 196
        }
    }
}

extension RecordViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude), zoomTo: 14)
        mapView.moveCamera(cameraUpdate)
        
        setLocationOverlayIcon(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserCurrentLocationAuthorization()
    }

    func checkUserCurrentLocationAuthorization() {
        let authorizationStatus = locationManager.authorizationStatus
        switch authorizationStatus {
        case .denied, .restricted:
            showLocationPermissionAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            startLocationManager()
        case .notDetermined:
            print("설정 x")
        default:
            break
        }
    }
    
    func showLocationPermissionAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "위치 권한을 허용해 주세요",
                          messageText: "위치 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
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
        present(alertViewController, animated: false)
    }
}

extension RecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? dummyCategory.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.registerId, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
            
            let category = dummyCategory[indexPath.row].title
            cell.configure(with: category)
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCell.registerId, for: indexPath) as? AddCategoryCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: section == 0 ? 16 : 0, bottom: 0, right: section == 0 ? 8 : 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cateogoryTitle = dummyCategory[indexPath.row].title
        return CGSize(width: cateogoryTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.caption02]).width + 24, height: 32)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension RecordViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

protocol EmptyRecordDelegate: AnyObject {
    func setEmptyRecordCellHeight()
}
