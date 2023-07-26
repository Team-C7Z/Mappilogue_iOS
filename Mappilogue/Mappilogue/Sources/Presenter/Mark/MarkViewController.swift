//
//  MarkViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import NMapsMap

class MarkViewController: NavigationBarViewController {
    var delegate: EmptyMarkDelegate?
    
    let locationManager = CLLocationManager()
    
    let mapView = NMFMapView()
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let addCategoryButton = AddCategoryButton()
    let currentLocationButton = UIButton()
    let writeMarkButton = WriteMarkButton()
    let containerView = UIView()
    let bottomSheetViewController = BottomSheetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocationManager()
        setBottomSheetViewController()
        setPanGesture()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startLocationManager()
        setLocationOverlayIcon()
    }
    
    override func setupProperty() {
        super.setupProperty()

        mapView.logoInteractionEnabled = false
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
        mapView.positionMode = .compass
    
        searchTextField.layer.cornerRadius = 12
        searchTextField.backgroundColor = .colorF9F8F7
        searchTextField.placeholder = "장소 또는 기록 검색"
        searchTextField.font = .body01
        searchTextField.addLeftPadding()
        applyShadow()
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        
        currentLocationButton.setImage(UIImage(named: "moveCurrentLocation"), for: .normal)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(mapView)
        mapView.addSubview(searchTextField)
        searchTextField.addSubview(searchButton)
        mapView.addSubview(addCategoryButton)
        view.addSubview(currentLocationButton)
        view.addSubview(writeMarkButton)
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
        
        writeMarkButton.snp.makeConstraints {
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
    
    private func startLocationManager() {
        locationManager.startUpdatingLocation()
    }
    
    private func setLocationOverlayIcon() {
        if let image = UIImage(named: "currentLocation") {
            let locationOverlayIcon = NMFOverlayImage(image: image)
            let locationOverlay = mapView.locationOverlay
            locationOverlay.icon = locationOverlayIcon
        }
    }
    
    private func applyShadow() {
        searchTextField.layer.shadowColor = UIColor.color000000.cgColor
        searchTextField.layer.shadowOpacity = 0.1
        searchTextField.layer.shadowRadius = 4.0
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchTextField.layer.masksToBounds = false
    }
    
    @objc func currentLocationButtonTapped(_ sender: UIButton) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 37.49794, lng: locationManager.location?.coordinate.longitude ?? 127.02759))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
 
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
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
        
        if gesture.state == .ended || gesture.state == .cancelled {
            containerView.snp.updateConstraints { make in
                make.height.equalTo(nearestHeight)
            }
            
            if nearestHeight == maxHeight {
                bottomSheetViewController.emptyCellHeight = view.frame.height - 200
                writeMarkButton.isHidden = true
            } else {
                bottomSheetViewController.emptyCellHeight = 196
                writeMarkButton.isHidden = false
            }
            bottomSheetViewController.tableView.reloadData()

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
        gesture.setTranslation(.zero, in: containerView)
    }
}

extension MarkViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude))
        mapView.moveCamera(cameraUpdate)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error)")
        
        showLocationPermissionAlert()
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
protocol EmptyMarkDelegate: AnyObject {
    func setEmptyMarkCellHeight()
}
