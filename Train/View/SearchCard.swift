//
//  SearchCard.swift
//  Train
//
//  Created by Александр Гладков on 28.06.2026.
//

import SwiftUI

struct SearchCard: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 0) {
                TextField("Откуда", text: .constant(""))
                    .padding()
                TextField("Куда", text: .constant(""))
                    .padding()
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                
            } label: {
                Image("ChangeButton")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
        }
        .padding()
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    SearchCard()
}
