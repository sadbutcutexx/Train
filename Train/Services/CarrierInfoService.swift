//
//  CarrierInfoService.swift
//  Train
//

import Foundation

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol: Sendable {
    func getCarrierInfo(code: String, system: String) async throws -> CarrierInfo
}

/// Сервис для получения информации о перевозчике
/// Делегирует сетевые запросы актору NetworkClient для предотвращения data races
final class CarrierInfoService: CarrierInfoServiceProtocol, Sendable {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCarrierInfo(code: String, system: String) async throws -> CarrierInfo {
        return try await networkClient.getCarrierInfo(code: code, system: system)
    }
}
