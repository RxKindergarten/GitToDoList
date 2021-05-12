//
//  AppInfo.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import Foundation

final class AppInfo {
    static let shared = AppInfo()
    // MARK: - Properties
    var infoDictionary: [String: Any] {
        return Bundle.main.infoDictionary!
    }
    var urlTypes: [NSDictionary] {
        return infoDictionary[AppInfoKey.CFBundleURLTypes] as? [NSDictionary] ?? [NSDictionary]()
    }
}
