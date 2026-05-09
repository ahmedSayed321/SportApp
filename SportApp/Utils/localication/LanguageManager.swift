//
//  LanguageManager.swift
//  SportApp
//
//  Created by AndrewMagdy on 08/05/2026.
//

import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    private init() {}
    
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
    }
    
    func setLanguage(_ language: String) {
        let direction: UISemanticContentAttribute = (language == "ar") ? .forceRightToLeft : .forceLeftToRight
        
        UserDefaults.standard.set(language, forKey: "AppLanguage")
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        
        UIView.appearance().semanticContentAttribute = direction
        UITabBar.appearance().semanticContentAttribute = direction
        UINavigationBar.appearance().semanticContentAttribute = direction
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.semanticContentAttribute = direction
            
            if let tabBarController = window.rootViewController as? UITabBarController {
                let tabBar = tabBarController.tabBar
                tabBar.semanticContentAttribute = direction
                tabBar.subviews.forEach {
                    $0.semanticContentAttribute = direction
                    $0.setNeedsLayout()
                    $0.layoutIfNeeded()
                }
            }
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func restartApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft) {
            window.rootViewController = rootVC
        }
    }
}
extension String {
    var localized: String {
            let lang = LanguageManager.shared.currentLanguage
            
            guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
                  let bundle = Bundle(path: path) else {
                return NSLocalizedString(self, comment: "")
            }
            
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
}
