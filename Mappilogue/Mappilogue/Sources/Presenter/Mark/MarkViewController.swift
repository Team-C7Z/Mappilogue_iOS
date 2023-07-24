//
//  MarkViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import NMapsMap

class MarkViewController: NavigationBarViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    let mapView = NMFMapView()
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let addCategoryButton = AddCategoryButton()
    let currentLocationButton = UIButton()
    let writeMarkButton = WriteMarkButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        searchTextField.layer.cornerRadius = 12
        searchTextField.backgroundColor = .colorF9F8F7
        searchTextField.placeholder = "장소 또는 기록 검색"
        searchTextField.font = .body01
        searchTextField.addLeftPadding()
        applyShadow()
        
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        
        currentLocationButton.setImage(UIImage(named: "currentLocation"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(mapView)
        mapView.addSubview(searchTextField)
        searchTextField.addSubview(searchButton)
        mapView.addSubview(addCategoryButton)
        mapView.addSubview(currentLocationButton)
        mapView.addSubview(writeMarkButton)
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
            $0.bottom.equalTo(mapView).offset(-57)
            $0.left.equalTo(mapView).offset(16)
            $0.width.height.equalTo(48)
        }
        
        writeMarkButton.snp.makeConstraints {
            $0.trailing.equalTo(mapView).offset(-16)
            $0.bottom.equalTo(mapView).offset(-60)
        }
    }
    
    private func applyShadow() {
        searchTextField.layer.shadowColor = UIColor.color000000.cgColor
        searchTextField.layer.shadowOpacity = 0.1
        searchTextField.layer.shadowRadius = 4.0
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchTextField.layer.masksToBounds = false
    }
}
