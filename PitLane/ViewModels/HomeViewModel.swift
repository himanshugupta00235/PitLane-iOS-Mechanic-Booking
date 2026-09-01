import SwiftUI

@MainActor
@Observable
final class HomeViewModel {
    private let repository: MechanicRepository

    var mechanics: [Mechanic] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var filteredMechanics: [Mechanic] {
        guard !searchText.isEmpty else { return mechanics }
        let query = searchText.lowercased()
        return mechanics.filter { mechanic in
            mechanic.name.lowercased().contains(query) ||
            mechanic.location.lowercased().contains(query) ||
            mechanic.services.contains { $0.lowercased().contains(query) }
        }
    }

    var showEmptyState: Bool {
        !isLoading && errorMessage == nil && !searchText.isEmpty && filteredMechanics.isEmpty
    }

    init(repository: MechanicRepository) {
        self.repository = repository
    }

    func loadMechanics() async {
        isLoading = true
        errorMessage = nil

        do {
            mechanics = try await repository.fetchMechanics()
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = APIError.unknown.errorDescription
        }

        isLoading = false
    }
}
