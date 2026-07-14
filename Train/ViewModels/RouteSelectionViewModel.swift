//
//  RouteSelectionViewModel.swift
//  Train
//

import SwiftUI

@MainActor
final class RouteSelectionViewModel: ObservableObject {
    
    @Published var routes: [Components.Schemas.Segment] = []
    @Published var alternativeRoutes: [Components.Schemas.Segment] = []
    @Published var isLoading = false
    @Published var showingAlternatives = false
    
    private let service: SchedualBetweenStationsServiceProtocol
    
    init(service: SchedualBetweenStationsServiceProtocol) {
        self.service = service
    }
    
    func load(
        fromCityCode: String,
        toCityCode: String,
        fromStationCode: String,
        toStationCode: String,
        fromStationTitle: String,
        toStationTitle: String
    ) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await service.getSchedualBetweenStations(
                from: fromCityCode,
                to: toCityCode
            )

            let segments = response.segments ?? []

            routes = segments.filter { segment in
                guard let fromStation = segment.from,
                      let toStation = segment.to else {
                    return false
                }

                let fromCode = fromStation.code ?? fromStation.codes?.yandex_code ?? ""
                let toCode = toStation.code ?? toStation.codes?.yandex_code ?? ""

                return fromCode == fromStationCode && toCode == toStationCode
            }

            if routes.isEmpty {
                alternativeRoutes = segments
                showingAlternatives = false
            } else {
                alternativeRoutes = []
                showingAlternatives = false
            }

        } catch {
        }
    }
}
