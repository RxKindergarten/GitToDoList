//
//  GitHubAccessManager.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import Moya
import RxCocoa
import RxSwift

final class GitHubAPIManager {
    
    static let shared = GitHubAPIManager()
    
    private let provider = MoyaProvider<GitHubAPIService>()
    
    private init() {}
    
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
    
    func getCode(){
        let scope = "repo user"
        let urlString = "https://github.com/login/oauth/authorize"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: GitHubAPIManager.clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        
        print("url = \(components.url!.absoluteString)")
        if let url = URL(string: components.url!.absoluteString), UIApplication.shared.canOpenURL(url)  {
            print("hi")
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
        }
    }
    
    //    class func removeAccessToken() {
    //        shared.accessToken.accept(nil)
    //    }
    //
    //    // MARK: - Con(De)structor
    //
    //    init() {
    //        accessToken
    //            .subscribe(onNext: { (accessToken) in
    //                guard let accessToken = accessToken else {return}
    //                AccessTokenRealmProxy().append(accessToken)
    //            })
    //            .disposed(by: disposeBag)
    //    }
    //
    //    // MARK: - Properties
    //
    //    let accessToken: BehaviorRelay<AccessToken?> = .init(value: AccessTokenRealmProxy().accessToken)
    //    var accessTokenValue: String? {
    //        return accessToken.value?.accessToken
    //    }
    
    private var info: [String: String]? = {
        guard let path = Bundle.main.path(forResource: "GitToDoList-Info", ofType: "plist"),
              let info = NSDictionary(contentsOfFile: path) as? [String: String] else {return nil}
        return info
    }()
    private var disposeBag = DisposeBag()
    
}

