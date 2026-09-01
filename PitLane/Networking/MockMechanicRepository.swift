import Foundation

final class MockMechanicRepository: MechanicRepository {
    private let simulatedDelay: UInt64 = 800_000_000 // 0.8 seconds
    
    func fetchMechanics() async throws -> [Mechanic] {
        try await Task.sleep(nanoseconds: simulatedDelay)
        
        guard let url = Bundle.main.url(forResource: "mechanics", withExtension: "json") else {
            throw APIError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let mechanics = try JSONDecoder().decode([Mechanic].self, from: data)
            return mechanics
        } catch is DecodingError {
            throw APIError.decodingError
        } catch {
            throw APIError.unknown
        }
    }
}
