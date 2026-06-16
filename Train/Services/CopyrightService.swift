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

// Функция для тестового вызова API
func testFetchCopyright() {
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
            let service = CopyrightService(
                client: client,
                apikey: "6a0ee87c-787b-4ba2-aa12-6616eaf14e21" // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching copyright...")
            let stations = try await service.getCopyright()
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched copyright: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching copyright: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
