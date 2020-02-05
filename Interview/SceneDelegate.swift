//
//  SceneDelegate.swift
//  Interview
//
//  Created by Fernando Sousa on 05/02/20.
//  Copyright © 2020 PicPay. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: ListContactsViewController())
            self.window = window
            window.makeKeyAndVisible()
            
        }
    }
}

