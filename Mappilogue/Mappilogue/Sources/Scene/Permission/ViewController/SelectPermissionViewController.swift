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
    weak var coordinator: SelectPermissionCoordinator?
    var viewModel = PermissionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestLocationPermission()
        viewModel.onboardingCompletion = {
            self.presentOnboardingViewController()
        }
    }
    
    func presentOnboardingViewController() {
        coordinator?.showOnboardingViewController()
    }
}
