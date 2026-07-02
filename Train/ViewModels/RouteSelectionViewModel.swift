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
            let response = try await service.getSchedualBetweenStations(from: from, to: to)

            // 👇 ВОТ СЮДА ДОБАВЬ
            print("RAW RESPONSE:", response)

            print("Segments:", response.segments?.count ?? 0)

            routes = response.segments ?? []

        } catch {
            print("ERROR:", error)
        }
    }
}
