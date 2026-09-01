import Foundation

struct Mechanic: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let rating: Double
    let distance: Double
    let location: String
    let address: String
    let isOpen: Bool
    let workingHours: String
    let phone: String
    let services: [String]
}
