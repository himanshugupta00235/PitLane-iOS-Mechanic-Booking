import Foundation

struct ServiceRequest: Hashable, Identifiable {
    let id = UUID()
    let mechanicId: Int
    let mechanicName: String
    let service: String
    let vehicleNumber: String
    let problemDescription: String
    let referenceId: String
    let timestamp: Date
    
    static func generateReferenceId() -> String {
        let number = Int.random(in: 1000...9999)
        return "#PL-\(number)"
    }
}
