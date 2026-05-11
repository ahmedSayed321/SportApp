//
//  SceneDelegate.swift
//  SportApp
//
//  Created by JETSMobileLabMini8 on 27/04/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
           
           window = UIWindow(windowScene: windowScene)
           
           // ✅ Apply language direction BEFORE anything renders
           let savedLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
           UserDefaults.standard.set([savedLanguage], forKey: "AppleLanguages")
           
           let direction: UISemanticContentAttribute = (savedLanguage == "ar") ? .forceRightToLeft : .forceLeftToRight
           UIView.appearance().semanticContentAttribute = direction
           UITabBar.appearance().semanticContentAttribute = direction
           UINavigationBar.appearance().semanticContentAttribute = direction
           window?.semanticContentAttribute = direction  // ✅ ع

        // Show the animated Splash screen first
        let splashVC = SplashViewController()
        splashVC.onAnimationFinished = { [weak self] in
            guard let self = self else { return }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateInitialViewController() ?? UIViewController()

            if !UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
                let onboardingController = OnboradingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                onboardingController.finishHandler = { [weak self] in
                    UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    self?.setRootViewController(mainViewController, animated: true)
                }
                self.setRootViewController(onboardingController, animated: true)
            } else {
                self.setRootViewController(mainViewController, animated: true)
            }
        }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splashVC
        window?.backgroundColor = .systemBackground
        
        // Apply saved theme preference or default to dark
        let isDark = UserDefaults.standard.object(forKey: "AppThemePreference") as? Bool ?? true
        window?.overrideUserInterfaceStyle = isDark ? .dark : .light
        
        window?.makeKeyAndVisible()
        if let savedLanguage = UserDefaults.standard.string(forKey: "AppLanguage") {
                UserDefaults.standard.set([savedLanguage], forKey: "AppleLanguages")
            }
            
            guard let _ = (scene as? UIWindowScene) else { return }
        
        
    }

    private func setRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard let window = window else { return }
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            }, completion: nil)
        } else {
            window.rootViewController = viewController
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

