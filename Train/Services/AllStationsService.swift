//
//  AllStationsService.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    
    func getAllStations() async throws -> AllStations
}

final class AllStationsService: AllStationsServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStations {
 
        let response = try await client.getAllStations(
            query: .init(apikey: apikey)
        )

        let body = try response.ok.body
            switch body {

            case .text_html_charset_utf_hyphen_8(let httpBody):

                var data = Data()

                for try await chunk in httpBody {
                    data.append(contentsOf: chunk)
                }

                return try JSONDecoder().decode(
                    AllStations.self,
                    from: data
                )
            }
    }
}
