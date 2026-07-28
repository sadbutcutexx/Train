//
//  AppContainer.swift
//  Train
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class AppContainer {

    static let shared = AppContainer()

    let allStationsService: AllStationsServiceProtocol
    let schedualBetweenStationsService: SchedualBetweenStationsServiceProtocol
    let carrierInfoService: CarrierInfoServiceProtocol

    private init() {

        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let apiKey = "6a0ee87c-787b-4ba2-aa12-6616eaf14e21"

        allStationsService = AllStationsService(
            client: client,
            apikey: apiKey
        )
        
        schedualBetweenStationsService = SchedualBetweenStationsService(
            client: client,
            apikey: apiKey
        )
        
        carrierInfoService = CarrierInfoService(
            client: client,
            apikey: apiKey
        )
    }
}
