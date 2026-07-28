//
//  SettingsViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    @Published var showUserAgreement: Bool = false
    
    let appVersion: String = "1.0 (beta)"
    let apiProvider: String = "Приложение использует API «Яндекс.Расписания»"
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
    
    func openUserAgreement() {
        showUserAgreement = true
    }
    
    func closeUserAgreement() {
        showUserAgreement = false
    }
    
    func resetSettings() {
        isDarkMode = false
    }
    
    func getAppInfo() -> String {
        return "\(apiProvider)\n\(appVersion)"
    }
}
