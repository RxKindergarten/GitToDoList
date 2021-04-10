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
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    @IBOutlet var githubLogoImage: UIImageView!
    @IBOutlet var emailTextFieldView: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextFieldView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBAction func loginButtonDidTap(_ sender: Any) {
        GitHubAPIManager.shared.getCode()
        print("tapped")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        validCheck()
        ApplicationNotificationCenter.tokenHasReceived.addObserver().bind { object in
            guard let code = object as? String else { return }
            print("code: \(code)")
            self.loginViewModel.login(with: code)
        }.disposed(by: self.disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뷰 클릭 시 키보드 내리기
        view.endEditing(true)
    }
}

extension LoginVC {
    private func layout() {
        view.backgroundColor = .white
        githubLogoImage.image = UIImage(named: "githubLogo")
        emailTextFieldView.setBorder(borderColor: .gray3, borderWidth: 1)
        passwordTextFieldView.setBorder(borderColor: .gray3, borderWidth: 1)
        emailTextFieldView.backgroundColor = .clear
        passwordTextFieldView.backgroundColor = .clear
        emailTextFieldView.setRounded(radius: 7)
        passwordTextFieldView.setRounded(radius: 7)
        emailTextField.placeholder = "insert email"
        passwordTextField.placeholder = "insert password"
        emailTextField.backgroundColor = .clear
        passwordTextField.backgroundColor = .clear
        passwordTextField.isSecureTextEntry = true
        loginButton.setRounded(radius: 7)
        loginButton.backgroundColor = .gray3
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .black
    }
    private func validCheck() {
        emailTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.emailTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map { $0 ? 1 : 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
}
