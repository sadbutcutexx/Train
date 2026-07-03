//
//  Untitled.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias SchedualBetweenStations = Components.Schemas.Segments

protocol SchedualBetweenStationsServiceProtocol {
    
    func getSchedualBetweenStations(from: String, to: String) async throws -> SchedualBetweenStations
}

final class SchedualBetweenStationsService: SchedualBetweenStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSchedualBetweenStations(from: String, to: String) async throws -> SchedualBetweenStations {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let response = try await client.getSchedualBetweenStations(
            query: .init(
                apikey: apikey,
                from: from,
                to: to,
                date: formatter.string(from: Date()),
                transport_types: "train"
            )
        )

        return try response.ok.body.json
    }
}
