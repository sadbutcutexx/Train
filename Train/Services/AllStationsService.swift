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

// Функция для тестового вызова API
func testFetchAllStations() {
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
            let service = AllStationsService(
                client: client,
                apikey: "6a0ee87c-787b-4ba2-aa12-6616eaf14e21" // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching AllStations...")
            let stations = try await service.getAllStations()
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched AllStations: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching AllStations: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
