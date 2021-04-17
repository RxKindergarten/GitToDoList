//
//  LoginVM.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import Moya
import RxCocoa
import RxSwift
import KeychainSwift

class LoginViewModel {
    // MARK: - Variables
    let disposeBag = DisposeBag()
    // MARK: - Input
    func login(with code: String) {
        GitHubAPIManager.shared.login(with: code).subscribe(onNext: { accessToken in
            print("saving accessToken ...")
            KeychainSwift().set(accessToken.accessToken, forKey: "accessToken")
            print("getting accessToken from keychain...")
            print(KeychainSwift().get("accessToken")!)
        }).disposed(by: disposeBag)
    }
}
