//
//  TermsOfUseViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import UIKit
import WebKit

class TermsOfUseViewController: BaseViewController {
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getTermsOfUserURL()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("이용약관", backButtonAction: #selector(backButtonTapped))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
     
        view.addSubview(webView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func openWebView(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func getTermsOfUserURL() {
        UserManager.shared.termsOfUse { result in
            switch result {
            case .success(let response):
                if let baseResponse = response as? BaseResponse<TermsOfUserResponse>, let result = baseResponse.result {
                    let url = result.link
                    self.openWebView(url: "https://www.youtube.com")
                }
            default:
                break
            }
        }
    }
}
