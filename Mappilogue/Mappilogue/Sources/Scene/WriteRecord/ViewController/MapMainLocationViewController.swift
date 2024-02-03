//
//  MapMainLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import UIKit
import NMapsMap
import MappilogueKit

class MapMainLocationViewController: NavigationBarViewController {
    weak var coordinator: MapMainLocationCoordinator?
    private var locationViewModel = LocationViewModel()
    var onSelectedMapLocation: ((String) -> Void)?

    let locationManager = CLLocationManager()
    let marker = NMFMarker()

    let mapView = NMFMapView()
    let mainLocationSettingView = MainLocationSettingView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLocationManager()
        checkUserCurrentLocationAuthorization()
    }

    override func setupProperty() {
        super.setupProperty()

        setPopBar(title: "대표 위치 설정")
        
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            coordinator?.popViewController()
        }
        
        setMapView()
        
        mainLocationSettingView.onSelectedMapLocation = { [weak self] address in
            guard let self = self else { return }
            
            selectMapLocation(address)
        }
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(mapView)
        view.addSubview(mainLocationSettingView)
    }

    override func setupLayout() {
        super.setupLayout()

        mapView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mainLocationSettingView.snp.top).offset(15)
        }

        mainLocationSettingView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view)
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
        mapView.addCameraDelegate(delegate: self)
    }

    func selectMapLocation(_ address: String) {
        self.onSelectedMapLocation?(address)
        self.coordinator?.popViewController()
    }
}

extension MapMainLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude), zoomTo: 14)
        mapView.moveCamera(cameraUpdate)

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
            presentLocationPermissionAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            startLocationManager()
        case .notDetermined:
            print("설정 x")
        default:
            break
        }
    }

    func presentLocationPermissionAlert() {
        let alert = Alert(titleText: "위치 권한을 허용해 주세요",
                          messageText: "위치 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                          cancelText: "닫기",
                          doneText: "설정으로 이동",
                          buttonColor: .green2EBD3D,
                          alertHeight: 182)
//        alertViewController.onDoneTapped = {
//            if let url = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
        coordinator?.showLocationPermissionAlert(alert: alert)
    }
}

extension MapMainLocationViewController: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let projection = mapView.projection
        let coord = projection.latlng(from: CGPoint(x: mapView.frame.width / 2, y: mapView.frame.height / 2 + 18))
        marker.position = NMGLatLng(lat: coord.lat, lng: coord.lng)
        marker.iconImage = NMFOverlayImage(name: Images.Image.imageMainLocation.rawValue)
        marker.width = 65
        marker.height = 36
        marker.mapView = mapView
    }

    func mapViewCameraIdle(_ mapView: NMFMapView) {
        locationViewModel.getAddress(long: mapView.longitude, lat: mapView.latitude)
        
        locationViewModel.$addressResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let address = result else { return }
                
                if let roadAddress = address.roadAddress {
                    self.mainLocationSettingView.configure(roadAddress.addressName)
                } else {
                    self.mainLocationSettingView.configure(address.address.addressName ?? "")
                }
            })
            .store(in: &locationViewModel.cancellables)
    }
}
