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
    
    // MARK: - input
    
    // MARK: - Output
    
    init() {
        /// Get Token from SceneDelegate
        ApplicationNotificationCenter.codeHasReceived
            .addObserver()
            .bind { object in
                guard let code = object as? String else { return }
                self.login(with: code)
            }
            .disposed(by: self.disposeBag)
    }
    
 
    /// Get Token from Github
    func login(with code: String) {
        GitHubAPIManager.shared.login(with: code)
            .subscribe(
                onNext: { accessToken in
                    KeychainSwift().set(accessToken.accessToken, forKey: "accessToken")
                    let token = KeychainSwift().get("accessToken")!
                    print(token)
                    NotificationCenter.default
                        .post(name: Notification.Name.passToken, object: nil)
                })
            .disposed(by: disposeBag)
    }
    
    
}
