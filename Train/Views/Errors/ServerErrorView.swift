//
//  ServerErrorView.swift
//  Train
//
//  Created by Александр Гладков on 07.07.2026.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack(spacing: 16) {
                Image("ServerErrorImg")
                Text("Ошибка сервера")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color("TextColor"))
            }
        }
    }
}

#Preview {
    ServerErrorView()
}
