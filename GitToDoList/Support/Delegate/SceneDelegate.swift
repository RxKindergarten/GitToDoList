//
//  SceneDelegate.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/17.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let loginViewModel = LoginViewModel()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window?.overrideUserInterfaceStyle = .light
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "gittodolist://") {
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    // call back url을 통해 넘어온 code 로 access token 얻을 수 있는 API 호출
                    loginViewModel.login(with: code)
                }
            }
        }
    }
}
