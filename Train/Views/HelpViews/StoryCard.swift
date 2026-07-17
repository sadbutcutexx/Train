//
//  StoryCard.swift
//  Train
//

import SwiftUI

struct StoryCard: View {
    let story: Story
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                // Story image
                if let uiImage = UIImage(named: story.imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 140)
                        .clipped()
                } else {
                    // Fallback color if image not found
                    Color.gray
                        .frame(width: 100, height: 140)
                }
                
                // Gradient overlay for text readability
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                // Story title
                Text(story.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding(8)
            }
            .frame(width: 100, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(story.isViewed ? Color.clear : Color.blue, lineWidth: 3)
            )
            .opacity(story.isViewed ? 0.5 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    StoryCard(story: Story(id: 1, title: "Text Text Text Text T...", imageName: "StoriesStubImage", isViewed: false)) {
        
    }
}
