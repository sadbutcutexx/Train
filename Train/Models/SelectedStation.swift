//
//  SelectedStation.swift
//  Train
//

import Foundation

struct SelectedStation: Sendable {
    let title: String        // "Москва (Ярославский вокзал)" — для отображения
    let stationTitle: String // "Ярославский вокзал" — оригинальное название
    let code: String         // код станции
    let cityCode: String     // код города
}
