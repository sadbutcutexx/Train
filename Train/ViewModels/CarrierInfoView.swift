//
//  CarrierInfoView.swift
//  Train
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    let carrier: Components.Schemas.Carrier
    
    var body: some View {
        VStack(spacing: 0) {
            if let logoURL = carrier.logo, let url = URL(string: logoURL) {
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
                if let title = carrier.title {
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                }
                
                if let email = carrier.email {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Link(email, destination: URL(string: "mailto:\(email)")!)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.blue)
                    }
                }
                
                if let phone = carrier.phone {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Link(phone, destination: URL(string: "tel:\(phone.replacingOccurrences(of: " ", with: ""))")!)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.blue)
                    }
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
