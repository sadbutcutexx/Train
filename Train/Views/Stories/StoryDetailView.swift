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
    
    @StateObject private var viewModel: StoryDetailViewModel
    
    init(stories: Binding<[Story]>, startIndex: Int) {
        self._stories = stories
        self.startIndex = startIndex
        self._viewModel = StateObject(wrappedValue: StoryDetailViewModel(stories: stories, startIndex: startIndex))
        print("StoryDetailView init with startIndex: \(startIndex)")
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                TabView(selection: $viewModel.currentIndex) {
                    ForEach(stories.indices, id: \.self) { index in
                        storyContentView(for: stories[index], geometry: geometry)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .onChange(of: viewModel.currentIndex) { oldValue, newValue in
                    Task {
                        await viewModel.handleIndexChange(oldValue: oldValue, newValue: newValue)
                    }
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        StoryProgressBar(
                            segmentCount: stories.count,
                            currentIndex: viewModel.currentIndex,
                            progress: viewModel.progress
                        )
                        .frame(height: 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Close button tapped")
                            viewModel.stopTimer()
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
                            viewModel.moveToPreviousStory()
                        }
                    
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if viewModel.shouldDismiss() {
                                viewModel.stopTimer()
                                dismiss()
                            } else {
                                viewModel.moveToNextStory()
                            }
                        }
                }
                .zIndex(1)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width < -50 {
                        if viewModel.shouldDismiss() {
                            viewModel.stopTimer()
                            dismiss()
                        } else {
                            viewModel.moveToNextStory()
                        }
                    } else if value.translation.width > 50 {
                        viewModel.moveToPreviousStory()
                    }
                }
        )
        .statusBarHidden(true)
        .onAppear {
            print("StoryDetailView appeared")
            viewModel.markAsViewed(index: viewModel.currentIndex)
            viewModel.startTimer()
        }
        .onDisappear {
            print("StoryDetailView disappeared")
            viewModel.stopTimer()
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
}

#Preview {
    @Previewable @State var stories = [
        Story(id: 1, title: "Story One", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 2, title: "Story Two", imageName: "StoriesStubImage", isViewed: false),
        Story(id: 3, title: "Story Three", imageName: "StoriesStubImage", isViewed: true)
    ]
    
    StoryDetailView(stories: $stories, startIndex: 0)
}
