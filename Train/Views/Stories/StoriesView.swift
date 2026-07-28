//
//  StoriesView.swift
//  Train
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var viewModel = StoriesViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.stories.indices, id: \.self) { index in
                    StoryCard(story: viewModel.stories[index]) {
                        viewModel.selectStory(at: index)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .fullScreenCover(isPresented: $viewModel.showStoryDetail) {
            StoryDetailView(stories: $viewModel.stories, startIndex: viewModel.selectedStoryIndex)
        }
    }
}

#Preview {
    StoriesView()
}
