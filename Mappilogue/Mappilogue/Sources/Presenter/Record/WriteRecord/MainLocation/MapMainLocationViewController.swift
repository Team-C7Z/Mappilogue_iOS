//
//  MapMainLocationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MapMainLocationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar("대표 위치 설정", backButtonAction: #selector(backButtonTapped))
    }
    

}
