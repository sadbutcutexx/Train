//
//  StoryDetailViewModel.swift
//  Train
//

import SwiftUI
import Combine

@MainActor
final class StoryDetailViewModel: ObservableObject {
    
    @Published var currentIndex: Int
    @Published var progress: Double = 0
    @Published var isAutoTransition = false
    
    private var timerSubscription: AnyCancellable?
    private let storyDuration: Double = 5.0
    
    var stories: Binding<[Story]>
    
    init(stories: Binding<[Story]>, startIndex: Int) {
        self.stories = stories
        self.currentIndex = startIndex
    }
    
    func startTimer() {
        print("Timer started")
        let timer = Timer.publish(every: 0.1, on: .main, in: .common)
        
        timerSubscription = timer
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.progress += 0.1 / self.storyDuration
                
                if self.progress >= 0.99 {
                    self.progress = 0
                    self.isAutoTransition = true
                    self.moveToNextStory()
                }
            }
    }
    
    func stopTimer() {
        print("Timer stopped")
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    func moveToNextStory() {
        print("Next story from \(currentIndex)")
        if currentIndex < stories.wrappedValue.count - 1 {
            currentIndex += 1
        }
    }
    
    func moveToPreviousStory() {
        print("Previous story from \(currentIndex)")
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func markAsViewed(index: Int) {
        guard index < stories.wrappedValue.count else { return }
        stories.wrappedValue[index].isViewed = true
        print("Marked story \(index) as viewed")
    }
    
    func resetProgress() {
        progress = 0
    }
    
    func handleIndexChange(oldValue: Int, newValue: Int) async {
        print("Story changed to index: \(newValue), isAuto: \(isAutoTransition)")
        
        if isAutoTransition {
            isAutoTransition = false
        } else {
            progress = 0
        }
        
        stopTimer()
        markAsViewed(index: newValue)
        
        try? await Task.sleep(for: .milliseconds(100))
        startTimer()
    }
    
    func shouldDismiss() -> Bool {
        return currentIndex >= stories.wrappedValue.count - 1
    }
}
