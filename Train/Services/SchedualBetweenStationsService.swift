//
//  Untitled.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession

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
        
        let response = try await client.getSchedualBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}

// Функция для тестового вызова API
func testFetchSchedualBetweenStations() {
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
            let service = SchedualBetweenStationsService(
                client: client,
                apikey: "fdb1aa1c-5f8c-443d-8a3e-f858ff369560" // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching schedule...")
            let stations = try await service.getSchedualBetweenStations(
                from: "c213",
                to: "c14",
            )
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched schedule: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching schedule: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
