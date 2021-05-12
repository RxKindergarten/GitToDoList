//
//  GitHupLoginAPI.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import Moya
import RxSwift
import RxCocoa

enum GitHubAPIService {
    case login(code: String)
}

extension GitHubAPIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    var path: String {
        switch self {
        case .login:
            return "/login/oauth/access_token"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .login(let code):
            let params: [String: Any] = [
                "client_id": GitHubClientManager.clientID,
                "client_secret": GitHubClientManager.clientSecret,
                "code": code
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
}
