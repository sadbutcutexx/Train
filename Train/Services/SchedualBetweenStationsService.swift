//
//  SchedualBetweenStationsService.swift
//  Train
//

import Foundation

typealias SchedualBetweenStations = Components.Schemas.Segments

protocol SchedualBetweenStationsServiceProtocol: Sendable {
    func getSchedualBetweenStations(from: String, to: String) async throws -> SchedualBetweenStations
}

/// Сервис для получения расписания между станциями
/// Делегирует сетевые запросы актору NetworkClient для предотвращения data races
final class SchedualBetweenStationsService: SchedualBetweenStationsServiceProtocol, Sendable {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getSchedualBetweenStations(from: String, to: String) async throws -> SchedualBetweenStations {
        return try await networkClient.getScheduleBetweenStations(from: from, to: to)
    }
}
