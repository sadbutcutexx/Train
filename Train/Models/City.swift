//
//  City.swift
//  Train
//

import Foundation

struct Station: Identifiable {
    let id = UUID()
    let title: String
    let code: String
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let stations: [Station]
}
