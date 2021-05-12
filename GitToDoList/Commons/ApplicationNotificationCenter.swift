//
//  ApplicationNotificationCenter.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/04/10.
//

import Foundation
import UIKit

enum ApplicationNotificationCenter: NotificationCenterProtocol {
    case willEnterForeground
    case didReceiveMemoryWarning
    case codeHasReceived
    var name: Notification.Name {
        switch self {
        case .willEnterForeground:
            return UIApplication.willEnterForegroundNotification
        case .didReceiveMemoryWarning:
            return UIApplication.didReceiveMemoryWarningNotification
        case .codeHasReceived:
            return Notification.Name("ApplicationNotificationCenter.tokenHasReceived")
        }
    }
}
