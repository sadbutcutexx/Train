//
//  CitySelectionViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class CitySelectionViewModel: ObservableObject {

    @Published var cities: [City] = []
    @Published var isLoading = false

    private let service: AllStationsServiceProtocol

    init(service: AllStationsServiceProtocol) {
        self.service = service
    }

    func load() async {

        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await service.getAllStations()
            cities = map(response)
        } catch {
            print(error)
            cities = []
        }
    }

    private func map(_ response: AllStations) -> [City] {

        guard let countries = response.countries else {
            return []
        }

        let regions = countries.flatMap { $0.regions ?? [] }

        let settlements = regions.flatMap { $0.settlements ?? [] }

        let cities: [City] = settlements.compactMap { settlement in

            guard let name = settlement.title, !name.isEmpty else {
                return nil
            }

            let stations: [Station] = (settlement.stations ?? []).compactMap { station in
                guard let title = station.title, !title.isEmpty else {
                    return nil
                }

                return Station(
                    title: title,
                    code: station.codes?.yandex_code ?? ""
                )
            }

            return City(
                name: name,
                stations: stations
            )
        }

        return cities.sorted { $0.name < $1.name }
    }
}
