//
//  RecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import NMapsMap

class RecordViewController: NavigationBarViewController {
    var delegate: EmptyRecordDelegate?
    
    let locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay?
    
    let mapView = NMFMapView()
    let searchTextField = SearchTextField()
    let searchButton = UIButton()
    let addCategoryButton = AddCategoryButton()
    let currentLocationButton = UIButton()
    let recordListButton = RecordListButton()
    let writeRecordButton = WriteRecordButton()
    let containerView = UIView()
    let bottomSheetViewController = BottomSheetViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationOverlay = mapView.locationOverlay
        setLocationManager()
        checkUserCurrentLocationAuthorization()
        setBottomSheetViewController()
        setPanGesture()
    }

    override func setupProperty() {
        super.setupProperty()
        
        mapView.logoInteractionEnabled = false
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
        mapView.positionMode = .compass
        
        searchTextField.delegate = self
        searchTextField.layer.applyShadow()
        setSearchTextFieldTapGestue()
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        
        currentLocationButton.setImage(UIImage(named: "moveCurrentLocation"), for: .normal)
        currentLocationButton.layer.applyShadow()
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        
        writeRecordButton.addTarget(self, action: #selector(writeRecordButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(mapView)
        mapView.addSubview(searchTextField)
        searchTextField.addSubview(searchButton)
        mapView.addSubview(addCategoryButton)
        view.addSubview(currentLocationButton)
        view.addSubview(recordListButton)
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
        
        addCategoryButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(8)
            $0.leading.equalTo(searchTextField)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-57)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(48)
        }
        
        recordListButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(writeRecordButton.snp.top).offset(-16)
        }
        
        writeRecordButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(containerView.snp.top).offset(-16)
        }
        
        containerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(mapView)
            $0.height.equalTo(44)
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
    
    private func setLocationOverlayIcon(latitude: Double, longitude: Double) {
        guard let locationOverlay = locationOverlay else { return }
        locationOverlay.hidden = false
        locationOverlay.location = NMGLatLng(lat: latitude, lng: longitude)
        locationOverlay.icon = NMFOverlayImage(name: "currentLocation")
        locationOverlay.iconWidth = 20
        locationOverlay.iconHeight = 20
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
    
    private func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        containerView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: containerView)
        let newContainerHeight = containerView.frame.height - translation.y
        
        let minHeight: CGFloat = 44
        let midHeight: CGFloat = 196
        let maxHeight: CGFloat = view.frame.height - 200
        
        let clampedHeight = min(max(newContainerHeight, minHeight), maxHeight)
        
        containerView.snp.updateConstraints { make in
            make.height.equalTo(clampedHeight)
        }
        
        var nearestHeight: CGFloat = 44
        
        if clampedHeight <= (midHeight + minHeight) / 2 {
            nearestHeight = minHeight
        } else if clampedHeight <= (maxHeight) / 2 {
            nearestHeight = midHeight
        } else {
            nearestHeight = maxHeight
        }
        
        if clampedHeight > view.frame.height / 2 {
            recordListButton.isHidden = true
            writeRecordButton.isHidden = true
        } else {
            recordListButton.isHidden = false
            writeRecordButton.isHidden = false
        }
     
        if gesture.state == .ended || gesture.state == .cancelled {
            containerView.snp.updateConstraints { make in
                make.height.equalTo(nearestHeight)
            }
            
            if nearestHeight == maxHeight {
                bottomSheetViewController.emptyCellHeight = view.frame.height - 200
            } else {
                bottomSheetViewController.emptyCellHeight = 196
            }
            bottomSheetViewController.collectionView.reloadData()

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        gesture.setTranslation(.zero, in: containerView)
    }
}

extension RecordViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude))
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
        alertViewController.onDeleteTapped = {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        present(alertViewController, animated: false)
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
