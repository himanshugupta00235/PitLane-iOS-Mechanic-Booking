import SwiftUI

@Observable
final class AppDependencies {
    let mechanicRepository: MechanicRepository
    
    init(mechanicRepository: MechanicRepository = MockMechanicRepository()) {
        self.mechanicRepository = mechanicRepository
    }
}

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue = AppDependencies()
}

extension EnvironmentValues {
    var dependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
