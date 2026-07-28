//
//  City.swift
//  Train
//

import Foundation

struct Station: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let code: String
}

struct City: Identifiable, Sendable {
    let id = UUID()
    let name: String
    let code: String
    let stations: [Station]
}
