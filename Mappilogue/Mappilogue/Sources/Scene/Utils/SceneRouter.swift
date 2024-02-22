//
//  SceneRouter.swift
//  Mappilogue
//
//  Created by hyemi on 2/4/24.
//

import UIKit

class SceneRouter: Router {
    public let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        onDismissed: (() -> Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    public func dismiss(animated: Bool) {
        //
    }
}
