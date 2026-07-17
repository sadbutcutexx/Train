//
//  StoriesView.swift
//  Train
//

import SwiftUI

struct StoriesView: View {
    @State private var stories = [
        Story(id: 1, title: "Story 1", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 2, title: "Story 2", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 3, title: "Story 3", imageName: "StoriesStubImage", isViewed: true),
        Story(id: 4, title: "Story 4", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 5, title: "Story 5", imageName: "StoriesStubImage", isViewed: false)
    ]
    
    @State private var selectedStoryIndex: Int = 0
    @State private var showStoryDetail = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories.indices, id: \.self) { index in
                    StoryCard(story: stories[index]) {
                        print("Tapped story at index: \(index)")
                        selectedStoryIndex = index
                        showStoryDetail = true
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .fullScreenCover(isPresented: $showStoryDetail) {
            StoryDetailView(stories: $stories, startIndex: selectedStoryIndex)
        }
    }
}

#Preview {
    StoriesView()
}
