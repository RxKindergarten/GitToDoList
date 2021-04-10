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
    // MARK: - IBAction
    @IBAction func loginButtonDidTap(_ sender: Any) {
        GitHubAPIManager.shared.getCode()
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setNotificationCenter()
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
    // MARK: - notification observer 추가
    private func setNotificationCenter() {
        ApplicationNotificationCenter.tokenHasReceived.addObserver().bind { object in
            guard let code = object as? String else { return }
            print("code: \(code)")
            self.loginViewModel.login(with: code)
        }.disposed(by: self.disposeBag)
    }
}
