//
//  StoryProgressBar.swift
//  Train
//

import SwiftUI

struct StoryProgressBar: View {
    let segmentCount: Int
    let currentIndex: Int
    let progress: Double
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<segmentCount, id: \.self) { index in
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.blue)
                            .frame(width: progressWidth(for: index, totalWidth: geometry.size.width))
                    }
                }
                .frame(height: 5)
            }
        }
    }
    
    private func progressWidth(for index: Int, totalWidth: CGFloat) -> CGFloat {
        if index < currentIndex {
            return totalWidth
        } else if index == currentIndex {
            return totalWidth * progress
        } else {
            return 0
        }
    }
}

#Preview {
    StoryProgressBar(segmentCount: 5, currentIndex: 1, progress: 0.5)
        .padding()
        .background(Color.black)
}
