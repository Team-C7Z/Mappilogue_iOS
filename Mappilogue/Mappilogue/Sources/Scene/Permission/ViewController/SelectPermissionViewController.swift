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
    var viewModel = PermissionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestPermission()
        viewModel.onboardingCompletion = { [weak self] in
            guard let self = self else { return }
            
            presentOnboardingViewController()
        }
    }
    
    private func presentOnboardingViewController() {
        let viewController = OnboardingViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
}
