//
//  CarrierInfoView.swift
//  Train
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CarrierInfoViewModel
    
    init(carrier: Components.Schemas.Carrier) {
        self._viewModel = StateObject(wrappedValue: CarrierInfoViewModel(
            carrier: carrier,
            service: AppContainer.shared.carrierInfoService
        ))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let logoURL = viewModel.displayLogo, let url = URL(string: logoURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 100)
                        .padding(.top, 40)
                        .padding(.bottom, 32)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(width: 200, height: 100)
                        .padding(.top, 40)
                        .padding(.bottom, 32)
                }
            }
            
            VStack(alignment: .leading, spacing: 24) {
                Text(viewModel.displayTitle)
                    .font(.system(size: 24, weight: .bold))
                
                if let email = viewModel.displayEmail {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Button {
                        } label: {
                            Text(email)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                if let phone = viewModel.displayPhone {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Button {
                        } label: {
                            Text(phone)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color("BackgroundColor"), for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                        Text("")
                    }
                    .foregroundColor(Color("TextColor"))
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarrierInfoView(carrier: Components.Schemas.Carrier(
            code: 0,
            title: "ОАО «РЖД»",
            phone: "+7 (904) 329-27-71",
            logo: "https://example.com/logo.png",
            email: "i.lozgkina@yandex.ru"
        ))
    }
}
