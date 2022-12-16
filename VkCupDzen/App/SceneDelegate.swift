//
//  SceneDelegate.swift
//  SomeVKCupProject
//
//  Created by Павел Кай on 11.12.2022.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = CategoryViewController()
        window.makeKeyAndVisible()
        
        self.window = window
    }

}

