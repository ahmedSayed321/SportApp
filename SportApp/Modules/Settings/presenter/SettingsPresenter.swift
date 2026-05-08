import Foundation

protocol SettingsViewProtocol: AnyObject {
    func updateTheme(isDark: Bool, animated: Bool)
}

protocol SettingsPresenterProtocol {
    func loadTheme()
    func changeTheme(isDark: Bool)
}

class SettingsPresenter: SettingsPresenterProtocol {
    private weak var view: SettingsViewProtocol?
    private let themeKey = "AppThemePreference"
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func loadTheme() {
        let isDark: Bool
        if UserDefaults.standard.object(forKey: themeKey) == nil {
            isDark = true // Default to dark mode
            UserDefaults.standard.set(true, forKey: themeKey)
        } else {
            isDark = UserDefaults.standard.bool(forKey: themeKey)
        }
        view?.updateTheme(isDark: isDark, animated: false)
    }
    
    func changeTheme(isDark: Bool) {
        UserDefaults.standard.set(isDark, forKey: themeKey)
        view?.updateTheme(isDark: isDark, animated: true)
    }
}
