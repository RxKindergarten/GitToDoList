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
    let disposeBag = DisposeBag()
    let emailTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(emailTextPublishSubject.asObservable(), passwordTextPublishSubject.asObservable().startWith("")).map { email, password in
            return email.count > 3 && password.count > 3
        }.startWith(false)
    }
    func login(with code: String) {
        GitHubAPIManager.shared.login(with: code).subscribe(onNext: { accessToken in
            print(accessToken.accessToken)
        }).disposed(by: disposeBag)
    }
}
