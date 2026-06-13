//
//  RouteStationsService.swift
//  Train
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsService {
    
    func getRouteStations(uid: String) async throws -> RouteStations
}

final class RouteTestsStationsService: RouteStationsService {
    
    private let client:Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(uid: String) async throws -> RouteStations {
        
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
}

// Функция для тестового вызова API
func testFetchRouteStations() {
    // Создаём Task для выполнения асинхронного кода
    
    let apikey = "fdb1aa1c-5f8c-443d-8a3e-f858ff369560"
    
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
            let service = RouteTestsStationsService(
                client: client,
                apikey: apikey // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
            )
            
            // 3. Вызываем метод сервиса
            print("Fetching route stations...")
            
            let schedule = try await StationScheduleService(client: client, apikey: apikey).getStationSchedule(
                station: "s9600213"
            )
            
            guard let first = schedule.schedule?.first else {
                return
            }
            
            guard let uid = first.thread?.uid else {
                return
            }

            let stations = try await service.getRouteStations(
                uid: uid
            )
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched route stations: \(stations)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching route stations: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}
