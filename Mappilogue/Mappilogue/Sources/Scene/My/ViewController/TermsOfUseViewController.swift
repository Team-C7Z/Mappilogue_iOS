//
//  TermsOfUseViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import UIKit
import WebKit

class TermsOfUseViewController: BaseViewController {
    var userViewModel = UserViewModel()
    
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
        userViewModel.getTermsOfUse()
        
        userViewModel.$termsOfUserResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let result else { return }
                self.handleTermsOfUserResponse(result)
            })
            .store(in: &userViewModel.cancellables)
    }
    
    func handleTermsOfUserResponse(_ response: Any) {
        guard let baseResponse = response as? BaseDTO<TermsOfUserDTO>, let result = baseResponse.result else { return }
        
        let url = result.link
        self.openWebView(url: url)
    }
}
