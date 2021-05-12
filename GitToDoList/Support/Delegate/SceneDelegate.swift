//
//  SceneDelegate.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/17.
//

import UIKit
import RxSwift
import KeychainSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window?.overrideUserInterfaceStyle = .light
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "gittodolist://") {
                // code랑 access token이랑 맞바꿔야된다!
                // code가 10분 안에 만료됨.
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    // call back url을 통해 넘어온 code 로 access token 얻을 수 있는 API 호출
                    print("code: \(code)")
                    ApplicationNotificationCenter.codeHasReceived.post(object: code)
                    
                }
            }
        }
    }
}
