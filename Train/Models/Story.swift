//
//  Story.swift
//  Train
//

import Foundation

struct Story: Identifiable {
    let id: Int
    let title: String
    let imageName: String
    var isViewed: Bool = false
}

struct StoryContent: Identifiable {
    let id: Int
    let imageName: String
    let title: String
    let description: String
}
