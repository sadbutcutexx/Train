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

        return settlements.compactMap { settlement in
            print("ГОРОД:", settlement.title ?? "")
            print("КОД ГОРОДА:", settlement.codes?.yandex_code ?? "нет")

            guard let name = settlement.title, !name.isEmpty else {
                return nil
            }

            let stations = (settlement.stations ?? [])
                .filter {
                    $0.transport_type == "train"
                }
                .compactMap { station -> Station? in

                    guard
                        let title = station.title,
                        !title.isEmpty
                    else {
                        return nil
                    }

                    let code = station.code ?? station.codes?.yandex_code ?? ""

                    guard !code.isEmpty else {
                        return nil
                    }

                    return Station(
                        title: title,
                        code: code
                    )
                }

            let cityCode = settlement.codes?.yandex_code ?? ""

            return City(
                name: name,
                code: cityCode,
                stations: stations
            )
        }
        .sorted { $0.name < $1.name }
    }
}
