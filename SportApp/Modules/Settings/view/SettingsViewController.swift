//
//  SettingsViewController.swift
//  SportApp
//
//  Created by Me3bed on 09/05/2026.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    @IBOutlet weak var langLabel: UILabel!
    
    var presenter: SettingsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        applyNavigationBarAppearance()
        presenter = SettingsPresenter(view: self)
        presenter.loadTheme()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationBarAppearance()
        darkModeLabel.text="dark_mode".localized
        langLabel.text="lang".localized
        
    }

    private func applyNavigationBarAppearance() {
        self.tabBarController?.navigationItem.title = "setting_tab".localized
        self.tabBarController?.navigationItem.leftBarButtonItem = nil

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appPrimaryBackground
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemGreen,
            .font: UIFont.boldSystemFont(ofSize: 22)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemGreen
    }

    @IBAction func themeModeSwitch(_ sender: UISwitch) {
        presenter.changeTheme(isDark: sender.isOn)
    }

    @IBAction func languageModeSwitch(_ sender: Any) {
        let current = LanguageManager.shared.currentLanguage
           let newLanguage = current == "en" ? "ar" : "en"
           
           let alert = UIAlertController(
               title: newLanguage == "ar" ? "تغيير اللغة" : "Change Language",
               message: newLanguage == "ar" ? "سيتم إعادة تشغيل التطبيق" : "App will restart",
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: newLanguage == "ar" ? "موافق" : "OK", style: .default) { _ in
               LanguageManager.shared.setLanguage(newLanguage)
               LanguageManager.shared.restartApp()
           })
           
           alert.addAction(UIAlertAction(title: newLanguage == "ar" ? "إلغاء" : "Cancel", style: .cancel))
           
           present(alert, animated: true)
    }
    
    func updateTheme(isDark: Bool, animated: Bool) {
        // Set the switch to match the current theme
        if let themeSwitch = themeSwitch, themeSwitch.isOn != isDark {
            themeSwitch.isOn = isDark
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                if animated {
                    let transitionOption: UIView.AnimationOptions = isDark ? .transitionFlipFromRight : .transitionFlipFromLeft
                    UIView.transition(with: window, duration: 0.6, options: transitionOption, animations: {
                        window.overrideUserInterfaceStyle = isDark ? .dark : .light
                    }, completion: nil)
                } else {
                    window.overrideUserInterfaceStyle = isDark ? .dark : .light
                }
            }
        }
    }
}
