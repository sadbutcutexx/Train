//
//  MainView.swift
//  Train
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var showUserAgreement = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(white: 0.6, alpha: 1.0)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Image("ScheduleTabItemEnabled")
                        .renderingMode(.template)
                }
                .tag(0)

            SettingsView(showUserAgreement: $showUserAgreement)
                .tabItem {
                    Image("SettingsTabItemEnabled")
                        .renderingMode(.template)
                }
                .tag(1)
        }
        .tint(isDarkMode ? .white : .black)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .fullScreenCover(isPresented: $showUserAgreement) {
            NavigationStack {
                UserAgreementView()
            }
        }
    }
}

#Preview {
    MainView()
}
