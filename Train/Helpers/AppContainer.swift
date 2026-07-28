//
//  AppContainer.swift
//  Train
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

actor NetworkClient {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(
            query: .init(apikey: apiKey)
        )
        
        let body = try response.ok.body
        switch body {
        case .text_html_charset_utf_hyphen_8(let httpBody):
            var data = Data()
            for try await chunk in httpBody {
                data.append(contentsOf: chunk)
            }
            return try JSONDecoder().decode(AllStations.self, from: data)
        }
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> SchedualBetweenStations {
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
                apikey: apiKey,
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

    func getCarrierInfo(code: String, system: String) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(
            query: .init(
                apikey: apiKey,
                code: code,
                system: system
            )
        )
        return try response.ok.body.json
    }
}

final class AppContainer {
    
    static let shared = AppContainer()
    
    let networkClient: NetworkClient
    let allStationsService: AllStationsServiceProtocol
    let schedualBetweenStationsService: SchedualBetweenStationsServiceProtocol
    let carrierInfoService: CarrierInfoServiceProtocol
    
    private init() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let apiKey = "6a0ee87c-787b-4ba2-aa12-6616eaf14e21"
        
        self.networkClient = NetworkClient(client: client, apiKey: apiKey)
        
        self.allStationsService = AllStationsService(networkClient: networkClient)
        self.schedualBetweenStationsService = SchedualBetweenStationsService(networkClient: networkClient)
        self.carrierInfoService = CarrierInfoService(networkClient: networkClient)
    }
}
