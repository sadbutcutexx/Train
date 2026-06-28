//
//  StoryCard.swift
//  Train
//

import SwiftUI

struct StoryCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("StoriesStubImage")
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 180)
                .clipped()
            
            LinearGradient(
                colors: [.clear, .black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            Text("Text Text\nText Text")
                .font(.caption)
                .foregroundColor(.white)
                .padding(8)
        }
        .frame(width: 90, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue, lineWidth: 5)
                .padding(2)
        }
    }
}

#Preview {
    StoryCard()
}
