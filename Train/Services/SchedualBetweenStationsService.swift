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
        
        let dateString = formatter.string(from: Date())

        print("🔍 API REQUEST:")
        print("  from: \(from)")
        print("  to: \(to)")
        print("  date: \(dateString)")
        print("  transport_types: train")

        let response = try await client.getSchedualBetweenStations(
            query: .init(
                apikey: apikey,
                from: from,
                to: to,
                date: dateString,
                transport_types: "train"
            )
        )

        let result = try response.ok.body.json
        
        print("📦 API RESPONSE: \(result.segments?.count ?? 0) segments")

        return result
    }
}
