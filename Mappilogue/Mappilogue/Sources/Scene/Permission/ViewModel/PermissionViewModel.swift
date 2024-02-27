//
//  PermissionViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import CoreLocation

class PermissionViewModel: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var onboardingCompletion: (() -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestPermission() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, _ in
            if granted {
                UserDefaults.standard.set(true, forKey: "PushPermission")
            } else {
                UserDefaults.standard.set(false, forKey: "PushPermission")
            }
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            onboardingCompletion?()
        }
    }
}
