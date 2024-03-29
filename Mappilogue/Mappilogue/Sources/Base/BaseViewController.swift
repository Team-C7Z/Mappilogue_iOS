//
//  BaseViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import SnapKit
import MappilogueKit

protocol BaseViewControllerProtocol {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .grayF9F8F7
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}
}
