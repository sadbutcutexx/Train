//
//  City.swift
//  Train
//
//  Created by Александр Гладков on 28.06.2026.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let stations: [String]
}

let cities: [City] = [
    City(
        name: "Москва",
        stations: [
            "Курский вокзал",
            "Казанский вокзал",
            "Ленинградский вокзал"
        ]
    ),
    City(
        name: "Санкт-Петербург",
        stations: [
            "Московский вокзал",
            "Ладожский вокзал"
        ]
    ),
    City(
        name: "Сочи",
        stations: [
            "Сочи",
            "Адлер"
        ]
    )
]
