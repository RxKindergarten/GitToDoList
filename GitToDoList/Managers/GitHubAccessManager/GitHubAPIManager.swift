//
//  GitHubAPIManager.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/04/03.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

struct GitHubAPIManager {
    // MARK: - Variables
    static let shared = GitHubAPIManager()
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<GitHubAPIService>()
    // MARK: - Init
    init() {}
    // MARK: - github authorization code get API
    func getCode() {
        let scope = "repo user"
        let urlString = "https://github.com/login/oauth/authorize"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: GitHubClientManager.clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        print("url = \(components.url!.absoluteString)")
        if let url = URL(string: components.url!.absoluteString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
        }
    }
    // MARK: - github access token get API
    func login(with code: String) -> Observable<AccessToken> {
        return provider.rx
            .request(.login(code: code))
            .filterSuccessfulStatusAndRedirectCodes() // we tell it to only complete the call if the operation is successful, otherwise it will give us an error
            .map(AccessToken.self)
            .asObservable()
    }
}
