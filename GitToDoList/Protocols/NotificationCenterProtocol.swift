//
//  NotificationCenterProtocol.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/04/10.
//

import Foundation
import RxSwift

protocol NotificationCenterProtocol {
    var name: Notification.Name { get }
}

extension NotificationCenterProtocol {
    func addObserver() -> Observable<Any?> {
        return NotificationCenter.default.rx.notification(self.name).map { $0.object }
    }
    func post(object: Any? = nil) {
        NotificationCenter.default.post(name: self.name, object: object, userInfo: nil)
    }
}
