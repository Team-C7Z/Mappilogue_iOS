//
//  Alert.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public struct Alert {
    var titleText: String
    var messageText: String?
    var cancelText: String
    var doneText: String
    var buttonColor: UIColor
    var alertHeight: CGFloat
    
    public init(titleText: String, messageText: String? = nil, cancelText: String, doneText: String, buttonColor: UIColor, alertHeight: CGFloat) {
        self.titleText = titleText
        self.messageText = messageText
        self.cancelText = cancelText
        self.doneText = doneText
        self.buttonColor = buttonColor
        self.alertHeight = alertHeight
    }
}
