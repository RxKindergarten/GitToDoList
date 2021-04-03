//
//  GitHubAccessManager.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import Moya
import RxCocoa
import RxSwift

final class GitHubClientManager {
    static let shared = GitHubClientManager()

    // client 관련 정보
    class var clientID: String {
        guard let id = shared.info?["clientID"] else {fatalError()}
        return id
    }
    
    class var clientSecret: String {
        guard let secret = shared.info?["clientSecret"] else {fatalError()}
        return secret
    }
    
    class var callBackURLSchemes: String {
        guard let schemes = AppInfo.shared.urlTypes.first?[AppInfoKey.CFBundleURLSchemes] as? [String] else {fatalError()}
        return schemes.first!
    }
    
    private var info: [String: String]? = {
        guard let path = Bundle.main.path(forResource: "GitToDoList-Info", ofType: "plist"),
              let info = NSDictionary(contentsOfFile: path) as? [String: String] else {return nil}
        return info
    }()
    private var disposeBag = DisposeBag()
    
    
}
