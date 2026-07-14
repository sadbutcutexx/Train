//
//  NetworkErrorView.swift
//  Train
//
//  Created by Александр Гладков on 07.07.2026.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack(spacing: 16) {
                Image("NetworkErrorImg")
                Text("Нет интернета")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color("TextColor"))
            }
        }
    }
}

#Preview {
    NetworkErrorView()
}
