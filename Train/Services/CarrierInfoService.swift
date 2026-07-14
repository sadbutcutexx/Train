//
//  CarrierInfoService.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String, system: String) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {

    private let client: Client
    private let apiKey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apiKey = apikey
    }

    func getCarrierInfo(code: String, system: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}
