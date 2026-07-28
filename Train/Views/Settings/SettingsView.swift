//
//  SettingsView.swift
//  Train
//

import SwiftUI

struct SettingsView: View {
    @Binding var showUserAgreement: Bool
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Темная тема")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                        Toggle("", isOn: $viewModel.isDarkMode)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    
                    Divider()
                        .padding(.leading, 16)
                    
                    Button {
                        showUserAgreement = true
                    } label: {
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(viewModel.isDarkMode ? .white : .black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(viewModel.isDarkMode ? .white : .black)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                    }
                }
                .padding(.top, 24)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text(viewModel.apiProvider)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text("Версия \(viewModel.appVersion)")
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
    SettingsView(showUserAgreement: .constant(false))
}
