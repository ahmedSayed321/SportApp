//
//  SettingsViewController.swift
//  SportApp
//
//  Created by Me3bed on 09/05/2026.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    @IBOutlet weak var themeSwitch: UISwitch!
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
    }

    private func applyNavigationBarAppearance() {
        self.tabBarController?.title = "Settings"
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
    }
    
    func updateTheme(isDark: Bool, animated: Bool) {
        // Set the switch to match the current theme
        if let themeSwitch = themeSwitch, themeSwitch.isOn != isDark {
            themeSwitch.isOn = isDark
        }
        
        // Apply theme to all windows
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                if animated {
                    // Book page turn animation
                    let transitionOption: UIView.AnimationOptions = isDark ? .transitionFlipFromRight : .transitionFlipFromLeft
                    UIView.transition(with: window, duration: 0.6, options: transitionOption, animations: {
                        window.overrideUserInterfaceStyle = isDark ? .dark : .light
                    }, completion: nil)
                } else {
                    // Instant change without animation when just loading the view
                    window.overrideUserInterfaceStyle = isDark ? .dark : .light
                }
            }
        }
    }
}
