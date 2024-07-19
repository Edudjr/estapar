//
//  SceneDelegate.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

                let window = UIWindow(windowScene: scene)
                window.backgroundColor = .white

                window.rootViewController = compositionRoot()

                self.window = window
                window.makeKeyAndVisible()
    }

    private func compositionRoot() -> UIViewController {
        
        let helpCenter = HelpCenter()
        let homeViewModel = HomeViewModel(helpCenter: helpCenter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)

        let navigation = UINavigationController(rootViewController: homeViewController)

        return navigation
    }
}

