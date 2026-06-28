//
//  StoriesView.swift
//  Train
//

import SwiftUI

struct StoriesView: View {
    let items = Array(1...5)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    StoryCard()
                }
            }
            .padding()
            .padding(.leading, -16)
        }
    }
}

#Preview {
    StoriesView()
}
