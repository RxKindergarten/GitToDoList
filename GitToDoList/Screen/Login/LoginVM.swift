//
//  LoginVM.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import SafariServices

import Moya
import RxCocoa
import RxSwift

class LoginViewModel {
    
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(emailTextPublishSubject.asObservable(), passwordTextPublishSubject.asObservable().startWith("")).map { email, password in
            return email.count > 3 && password.count > 3
        }.startWith(false)
    }
//
//    private var disposeBag = DisposeBag()
//
//    // MARK: - Private methods
//
//    private func getLoginUrl() -> URL {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "github.com"
//        urlComponents.path = "/login/oauth/authorize"
//        let clientIDQuery = URLQueryItem(name: "client_id", value: GitHubAccessManager.clientID)
//        let scopeQuery = URLQueryItem(name: "scope", value: "user")
//        urlComponents.queryItems = [clientIDQuery, scopeQuery]
//        return urlComponents.url!
//    }
    
}

// MARK: - ViewModelType
//
//extension MyProfileLoginViewModel: ViewModelType {
//
//    struct Input {
//        let authTrigger: Driver<Void>
//    }
//    struct Output {
//        let accessToken: Driver<AccessToken>
//    }
//
//    func transform(input: Input) -> Output {
//        let code: Driver<String> = input.authTrigger.flatMapLatest({ [weak self] (_) -> Driver<String> in
//            guard let self = self else {return Driver<String>.empty()}
//
//            let code = Single<String>.create { [weak self] (observer) -> Disposable in
//                guard let self = self else {return Disposables.create()}
//
//                self.authSession = SFAuthenticationSession(url: self.getLoginUrl(),
//                                                           callbackURLScheme: GitHubAccessManager.callBackURLSchemes,
//                                                           completionHandler: { (url, error) in
//                                                            guard error == nil, let url = url, let code = url.queryParameters?["code"] else {
//                                                                observer(.error(error!))
//                                                                return
//                                                            }
//
//                                                            observer(.success(code))
//                })
//                self.authSession?.start()
//
//                return Disposables.create()
//                }
//                .asObservable()
//                .asDriverOnErrorJustNever()
//            return code
//        })
//        let accessToken: Driver<AccessToken> = code
//            .flatMapLatest { [weak self] in
//                guard let self = self else {return Driver<AccessToken>.empty()}
//
//                return self.useCase.getAccessToken(code: $0)
//        }
//        return Output(accessToken: accessToken)
//    }
//
//}
