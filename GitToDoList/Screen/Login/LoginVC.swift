//
//  LoginVC.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    // MARK: - Variables
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - IBOutlet
    @IBOutlet var githubLogoImage: UIImageView!
    @IBOutlet var loginButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.rx.tap
            .bind {
                GitHubAPIManager.shared.getCode()
            }
            .disposed(by: disposeBag)
        setNotificationCenter()
        layout()
    }
}

// MARK: - functions
extension LoginVC {
    
    // MARK: - layout 설정
    private func layout() {
        view.backgroundColor = .white
        githubLogoImage.image = UIImage(named: "githubLogo")
        loginButton.setRounded(radius: 7)
        loginButton.backgroundColor = .gray3
        loginButton.setTitle("Login with Github!", for: .normal)
        loginButton.tintColor = .black
    }
    
    private func setNotificationCenter() {
        // 화면 전환 담당
        NotificationCenter.default.rx.notification(Notification.Name.passToken)
            .subscribe(onNext: { _ in
                
                guard let window = self.view.window else { return }
                
                guard let tab = UIStoryboard.init(name: "Tab", bundle: nil)
                        .instantiateViewController(identifier: "TabVC") as? TabVC else { return }
                
                window.rootViewController = tab
                
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3

                UIView.transition(
                    with: window,
                    duration: duration,
                    options: options,
                    animations: {},
                    completion: nil
                )

                
            })
            .disposed(by: disposeBag)
    }
}
