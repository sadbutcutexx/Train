//
//  SettingsView.swift
//  Train
//

import SwiftUI

struct SettingsView: View {
    @State private var isOn = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Settings rows at the top
            VStack(spacing: 0) {
                HStack {
                    Text("Темная тема")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                    Toggle("", isOn: $isOn)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                HStack {
                    Text("Пользовательское соглашение")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
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
    }
}

#Preview {
    SettingsView()
}
