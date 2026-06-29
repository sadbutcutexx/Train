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

    private init() {

        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        allStationsService = AllStationsService(
            client: client,
            apikey: "6a0ee87c-787b-4ba2-aa12-6616eaf14e21"
        )
    }
}
