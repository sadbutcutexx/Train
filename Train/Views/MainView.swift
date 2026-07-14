//
//  MainView.swift
//  Train
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
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

            SettingsView()
                .tabItem {
                    Image("SettingsTabItemEnabled")
                        .renderingMode(.template)
                }
                .tag(1)
        }
        .tint(isDarkMode ? .white : .black)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
}
