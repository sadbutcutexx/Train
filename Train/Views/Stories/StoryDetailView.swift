//
//  StoryDetailView.swift
//  Train
//

import SwiftUI
import Combine

struct StoryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var stories: [Story]
    let startIndex: Int
    
    @State private var currentIndex: Int
    @State private var progress: Double = 0
    @State private var timerSubscription: AnyCancellable?
    @State private var isAutoTransition = false
    
    private let storyDuration: Double = 5.0
    
    init(stories: Binding<[Story]>, startIndex: Int) {
        self._stories = stories
        self.startIndex = startIndex
        self._currentIndex = State(initialValue: startIndex)
        print("StoryDetailView init with startIndex: \(startIndex)")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                TabView(selection: $currentIndex) {
                    ForEach(stories.indices, id: \.self) { index in
                        storyContentView(for: stories[index], geometry: geometry)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .onChange(of: currentIndex) { oldValue, newValue in
                    print("Story changed to index: \(newValue), isAuto: \(isAutoTransition)")
                    
                    if isAutoTransition {
                        isAutoTransition = false
                    } else {
                        progress = 0
                    }
                    
                    stopTimer()
                    markAsViewed(index: newValue)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        startTimer()
                    }
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        StoryProgressBar(
                            segmentCount: stories.count,
                            currentIndex: currentIndex,
                            progress: progress
                        )
                        .frame(height: 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Close button tapped")
                            stopTimer()
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color("BlackUniversal"))
                                .clipShape(Circle())
                                .contentShape(Circle())
                        }
                        .padding(.trailing, 16)
                        .padding(.top, 8)
                    }
                    
                    Spacer()
                }
                .zIndex(2)
                
                HStack(spacing: 0) {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            previousStory()
                        }
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            nextStory()
                        }
                }
                .zIndex(1)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width < -50 {
                        nextStory()
                    } else if value.translation.width > 50 {
                        previousStory()
                    }
                }
        )
        .statusBarHidden(true)
        .onAppear {
            print("StoryDetailView appeared")
            markAsViewed(index: currentIndex)
            startTimer()
        }
        .onDisappear {
            print("StoryDetailView disappeared")
            stopTimer()
        }
    }
    
    @ViewBuilder
    private func storyContentView(for story: Story, geometry: GeometryProxy) -> some View {
        ZStack(alignment: .bottomLeading) {
            if let uiImage = UIImage(named: story.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            } else {
                Color.blue
                    .overlay(
                        VStack {
                            Text("Story \(story.id)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.white)
                            Text("Image: \(story.imageName)")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    )
            }
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(story.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("TEXTETXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTXTX")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .lineLimit(3)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 8)
    }
    
    private func startTimer() {
        print("Timer started")
        let timer = Timer.publish(every: 0.1, on: .main, in: .common)
        
        timerSubscription = timer
            .autoconnect()
            .sink { [self] _ in
                progress += 0.1 / storyDuration
                
                if progress >= 0.99 {
                    progress = 0
                    isAutoTransition = true
                    nextStory()
                }
            }
    }
    
    private func stopTimer() {
        print("Timer stopped")
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    private func nextStory() {
        print("Next story from \(currentIndex)")
        if currentIndex < stories.count - 1 {
            currentIndex += 1
        } else {
            print("Reached end, dismissing")
            stopTimer()
            dismiss()
        }
    }
    
    private func previousStory() {
        print("Previous story from \(currentIndex)")
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    private func markAsViewed(index: Int) {
        stories[index].isViewed = true
        print("Marked story \(index) as viewed")
    }
}

#Preview {
    @Previewable @State var stories = [
        Story(id: 1, title: "Story One", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 2, title: "Story Two", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 3, title: "Story Three", imageName: "StoriesStubImage", isViewed: true)
    ]
    
    StoryDetailView(stories: $stories, startIndex: 0)
}
