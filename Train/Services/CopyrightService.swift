//
//  CopyrightService.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {

    private let client: Client
    private let apiKey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apiKey = apikey
    }

    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyrightInfo(query: .init(
            apikey: apiKey,
            format: "json"
        ))
        return try response.ok.body.json
    }
}
