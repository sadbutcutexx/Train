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

// Функция для тестового вызова API
func testFetchCarrierInfo() {
    // Создаём Task для выполнения асинхронного кода
    Task {
        do {
            // 1. Создаём экземпляр сгенерированного клиента
            let client = Client(
                // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                serverURL: try Servers.Server1.url(),
                // Указываем, какой транспорт использовать для отправки запросов
                transport: URLSessionTransport()
            )
            
            // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
            let service = CarrierInfoService(
                client: client,
                apikey: "YOUR API KEY" // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching CarrierInfo...")
            let stations = try await service.getCarrierInfo(code: "TK", system: "iata")
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched CarrierInfo: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching CarrierInfo: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
