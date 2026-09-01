import Foundation

protocol MechanicRepository: Sendable {
    func fetchMechanics() async throws -> [Mechanic]
}
