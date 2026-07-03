//
//  RouteSelectionViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class RouteSelectionViewModel: ObservableObject {
    
    @Published var routes: [Components.Schemas.Segment] = []
    @Published var isLoading = false
    
    private let service: SchedualBetweenStationsServiceProtocol
    
    init(service: SchedualBetweenStationsServiceProtocol) {
        self.service = service
    }
    
    func load(from: String, to: String) async {

        print("FROM:", from)
        print("TO:", to)

        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await service.getSchedualBetweenStations(
                from: from,
                to: to
            )

            let segments = response.segments ?? []

            print("RAW segments:", segments.count)

            routes = segments.filter { segment in

                guard let fromStation = segment.from,
                      let toStation = segment.to else {
                    return false
                }

                let fromMatch =
                    fromStation.codes?.yandex_code == from

                let toMatch =
                    toStation.codes?.yandex_code == to

                return fromMatch && toMatch
            }

            print("FILTERED routes:", routes.count)

        } catch {
            print("ERROR:", error)
        }
    }
}
