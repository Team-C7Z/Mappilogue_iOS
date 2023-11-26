//
//  SelectPermissionViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/24.
//

import UIKit
import Photos
import CoreLocation

class SelectPermissionViewController: BaseViewController {
    let locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in
                self.checkoutLocationPermission()
            }
        )
    }
    
    func presentOnboardingViewController() {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        present(onboardingViewController, animated: false)
    }
    
    func checkoutLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension SelectPermissionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            presentOnboardingViewController()
        }
     }
}
