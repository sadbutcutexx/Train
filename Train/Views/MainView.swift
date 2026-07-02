//
//  MainView.swift
//  Train
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Image(selectedTab == 0 ? "ScheduleTabItemEnabled" : "ScheduleTabItemDisabled")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(selectedTab == 1 ? "SettingsTabItemEnabled" : "SettingsTabItemDisabled")
                }
                .tag(1)
        }
    }
}

#Preview {
    MainView()
}
