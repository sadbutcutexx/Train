//
//  StoriesViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class StoriesViewModel: ObservableObject {
    
    @Published var stories: [Story] = []
    @Published var selectedStoryIndex: Int = 0
    @Published var showStoryDetail: Bool = false
    @Published var isLoading: Bool = false
    
    init() {
        loadStories()
    }
    
    func loadStories() {
        stories = [
            Story(id: 1, title: "Story 1", imageName: "StoriesStubImage", isViewed: false),
            Story(id: 2, title: "Story 2", imageName: "StoriesStubImage", isViewed: false),
            Story(id: 3, title: "Story 3", imageName: "StoriesStubImage", isViewed: true),
            Story(id: 4, title: "Story 4", imageName: "StoriesStubImage", isViewed: false),
            Story(id: 5, title: "Story 5", imageName: "StoriesStubImage", isViewed: false)
        ]
    }
    
    func selectStory(at index: Int) {
        print("Tapped story at index: \(index)")
        selectedStoryIndex = index
        showStoryDetail = true
    }
    
    func dismissStoryDetail() {
        showStoryDetail = false
    }
    
    func markStoryAsViewed(id: Int) {
        if let index = stories.firstIndex(where: { $0.id == id }) {
            stories[index].isViewed = true
        }
    }
}
