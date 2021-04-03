//
//  SceneDelegate.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window?.overrideUserInterfaceStyle = .light
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if url.absoluteString.starts(with: "gittodolist://") {
                if let code = url.absoluteString.split(separator: "=").last.map({ String($0) }) {
                    print("code:\(code)")
//                    LoginManager.shared.requestAccessToken(with: code)
                }
            }
        }
    }
}

