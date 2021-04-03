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
    
    static let shared = GitHubAPIManager()
    
    private let provider = MoyaProvider<GitHubAPIService>()
    
    init() {}
    
    func getCode(){
        let scope = "repo user"
        let urlString = "https://github.com/login/oauth/authorize"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: GitHubClientManager.clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        
        print("url = \(components.url!.absoluteString)")
        if let url = URL(string: components.url!.absoluteString), UIApplication.shared.canOpenURL(url)  {
            print("hi")
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
        }
    }
    
    func login(with code: String) -> Single<AccessToken> {
        print("code from manage: \(code)")
        return provider.rx
            .request(.login(code: code))
            .filterSuccessfulStatusAndRedirectCodes() // we tell it to only complete the call if the operation is successful, otherwise it will give us an error
            .map(AccessToken.self) // we map the response to our Codable objects
            
    }
    
}


