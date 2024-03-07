//
//  TermsOfUseViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import UIKit
import WebKit

class TermsOfUseViewController: NavigationBarViewController {
    var viewModel = TermsOfUseViewModel()
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.delegate = self
        viewModel.getTermsOfUse()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "이용약관")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
     
        view.addSubview(webView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        webView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func openWebView(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension TermsOfUseViewController: TermsOfUseDelegate {
    func getTermsOfUser(url: String) {
        openWebView(url: url)
    }
}
