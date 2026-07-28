//
//  AllStationsService.swift
//  Train
//

import Foundation

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol: Sendable {
    func getAllStations() async throws -> AllStations
}

/// Сервис для работы со списком всех станций
/// Делегирует сетевые запросы актору NetworkClient для предотвращения data races
final class AllStationsService: AllStationsServiceProtocol, Sendable {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getAllStations() async throws -> AllStations {
        return try await networkClient.getAllStations()
    }
}
