import SwiftUI

struct HomeView: View {
    @Environment(\.dependencies) private var dependencies
    @State private var viewModel: HomeViewModel?
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            content
                .background(Theme.background)
                .navigationTitle("PitLane")
                .navigationDestination(for: Mechanic.self) { mechanic in
                    MechanicDetailView(
                        mechanic: mechanic,
                        navigationPath: $navigationPath
                    )
                }
        }
        .task {
            if viewModel == nil {
                let vm = HomeViewModel(repository: dependencies.mechanicRepository)
                viewModel = vm
                await vm.loadMechanics()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if let viewModel {
            if viewModel.isLoading && viewModel.mechanics.isEmpty {
                VStack(spacing: 0) {
                    subtitle
                    LoadingSkeletonView()
                    Spacer()
                }
            } else if let errorMessage = viewModel.errorMessage, viewModel.mechanics.isEmpty {
                ErrorStateView(message: errorMessage) {
                    Task { await viewModel.loadMechanics() }
                }
            } else {
                mechanicList(viewModel: viewModel)
            }
        } else {
            VStack(spacing: 0) {
                subtitle
                LoadingSkeletonView()
                Spacer()
            }
        }
    }

    private func mechanicList(viewModel: HomeViewModel) -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                subtitle

                if viewModel.showEmptyState {
                    emptySearchState(query: viewModel.searchText)
                } else {
                    ForEach(Array(viewModel.filteredMechanics.enumerated()), id: \.element.id) { index, mechanic in
                        Button {
                            navigationPath.append(mechanic)
                        } label: {
                            MechanicLedgerRow(mechanic: mechanic)
                        }
                        .buttonStyle(.plain)

                        if index < viewModel.filteredMechanics.count - 1 {
                            LedgerDivider()
                                .padding(.horizontal, Theme.Spacing.screen)
                        }
                    }
                }
            }
        }
        .refreshable {
            await viewModel.loadMechanics()
        }
        .searchable(
            text: Binding(
                get: { viewModel.searchText },
                set: { viewModel.searchText = $0 }
            ),
            prompt: "Search by name, location, or service"
        )
    }

    private var subtitle: some View {
        HStack {
            Text("Garages near you — Gurgaon")
                .font(Theme.caption)
                .foregroundStyle(Theme.textSecondary)
            Spacer()
        }
        .padding(.horizontal, Theme.Spacing.screen)
        .padding(.vertical, Theme.Spacing.small)
    }

    private func emptySearchState(query: String) -> some View {
        VStack(spacing: Theme.Spacing.medium) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 36))
                .foregroundStyle(Theme.textSecondary)

            Text("No garages found for \"\(query)\"")
                .font(Theme.body)
                .foregroundStyle(Theme.textSecondary)
                .multilineTextAlignment(.center)

            Text("Try searching by name, location, or service type")
                .font(Theme.caption)
                .foregroundStyle(Theme.textSecondary.opacity(0.7))
        }
        .padding(.top, 60)
        .frame(maxWidth: .infinity)
    }
}
