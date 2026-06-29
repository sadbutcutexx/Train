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

        guard cities.isEmpty else { return }

        isLoading = true

        do {

            let response = try await service.getAllStations()

            cities = map(response)

        } catch {

            print(error)

        }

        isLoading = false
    }

    private func map(_ response: AllStations) -> [City] {

        guard let countries = response.countries else {
            return []
        }

        return countries

            .flatMap { $0.regions ?? [] }

            .flatMap { $0.settlements ?? [] }

            .compactMap { settlement in

                guard
                    let name = settlement.title,
                    !name.isEmpty
                else {
                    return nil
                }

                let stations = (settlement.stations ?? []).compactMap { station -> Station? in
                    guard
                        let title = station.title,
                        !title.isEmpty
                    else {
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

            .sorted {

                $0.name < $1.name

            }

    }

}
