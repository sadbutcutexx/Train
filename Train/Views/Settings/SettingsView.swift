//
//  SettingsView.swift
//  Train
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Settings rows at the top
                VStack(spacing: 0) {
                    HStack {
                        Text("Темная тема")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                        Toggle("", isOn: $isDarkMode)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    
                    Divider()
                        .padding(.leading, 16)
                    
                    NavigationLink(destination: UserAgreementView()) {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(isDarkMode ? .white : .black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                }
                .padding(.top, 24)
                
                Spacer()
                
                // Footer at the bottom
                VStack(spacing: 4) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 24)
            }
            .background(Color("BackgroundColor"))
        }
    }
}

#Preview {
    SettingsView()
}
