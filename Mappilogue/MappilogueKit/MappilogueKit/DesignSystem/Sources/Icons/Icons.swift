//
//  Icons.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class Icons {
    static let bundle = Bundle(for: Icons.self)
    
    public enum Icon: String {
        case defaultImage = "default"
        case logo = "logo"
        case notificationDefault = "notification_default"
        case notificationNew = "notification_new"
        case dismiss = "dismiss"
        case menu = "menu"
        case pop = "pop"
        case save = "save"
    }
    
    static public func icon(named: Icon) -> UIImage {
        return .load(name: named.rawValue)
    }
}
