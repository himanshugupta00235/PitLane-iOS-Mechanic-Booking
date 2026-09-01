import SwiftUI

@main
struct PitLaneApp: App {
    @State private var dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.dependencies, dependencies)
        }
    }
}
