import SwiftUI

struct MechanicDetailView: View {
    let mechanic: Mechanic
    @Binding var navigationPath: NavigationPath
    @State private var showRequestSheet = false
    @State private var submittedRequest: ServiceRequest?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Rating & Distance
                detailSection {
                    RatingDistanceLine(
                        rating: mechanic.rating,
                        distance: mechanic.distance,
                        location: mechanic.location
                    )
                }

                LedgerDivider()

                // Address
                detailSection {
                    DetailRow(icon: "mappin.and.ellipse", title: "Address") {
                        Text(mechanic.address)
                            .font(Theme.body)
                            .foregroundStyle(Theme.textPrimary)
                    }
                }

                LedgerDivider()

                // Working Hours
                detailSection {
                    DetailRow(icon: "clock", title: "Working Hours") {
                        Text(mechanic.workingHours)
                            .font(Theme.body)
                            .foregroundStyle(Theme.textPrimary)
                    }
                }

                LedgerDivider()

                // Phone
                if !mechanic.phone.isEmpty {
                    detailSection {
                        DetailRow(icon: "phone", title: "Phone") {
                            Link(formatPhone(mechanic.phone), destination: URL(string: "tel:\(mechanic.phone)")!)
                                .font(Theme.body)
                                .foregroundStyle(Theme.accent)
                        }
                    }

                    LedgerDivider()
                }

                // Services
                detailSection {
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        Label("Services", systemImage: "wrench.and.screwdriver")
                            .font(Theme.sectionLabel)
                            .foregroundStyle(Theme.textSecondary)

                        ServiceTagRow(services: mechanic.services, showAll: true)
                    }
                }

                LedgerDivider()

                // CTA
                VStack(spacing: Theme.Spacing.small) {
                    if !mechanic.isOpen {
                        HStack(spacing: Theme.Spacing.base) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 14))
                            Text("This garage is currently closed.")
                                .font(Theme.caption)
                        }
                        .foregroundStyle(Theme.closedColor)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }

                    PrimaryButton(
                        title: "Request Service",
                        isDisabled: !mechanic.isOpen
                    ) {
                        showRequestSheet = true
                    }
                }
                .padding(.horizontal, Theme.Spacing.screen)
                .padding(.vertical, Theme.Spacing.section)
            }
        }
        .background(Theme.background)
        .navigationTitle(mechanic.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: Theme.Spacing.small) {
                    Text(mechanic.name)
                        .font(.headline)
                    StatusStamp(isOpen: mechanic.isOpen)
                }
            }
        }
        .sheet(isPresented: $showRequestSheet) {
            RequestServiceView(mechanic: mechanic) { request in
                submittedRequest = request
                showRequestSheet = false
            }
        }
        .navigationDestination(item: $submittedRequest) { request in
            ConfirmationView(
                serviceRequest: request,
                navigationPath: $navigationPath
            )
        }
    }

    private func detailSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding(.horizontal, Theme.Spacing.screen)
        .padding(.vertical, Theme.Spacing.medium)
    }

    private func formatPhone(_ phone: String) -> String {
        guard phone.hasPrefix("+91") && phone.count == 13 else { return phone }
        let digits = phone.dropFirst(3)
        let part1 = digits.prefix(5)
        let part2 = digits.suffix(5)
        return "+91 \(part1) \(part2)"
    }
}

private struct DetailRow<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.base) {
            Label(title, systemImage: icon)
                .font(Theme.sectionLabel)
                .foregroundStyle(Theme.textSecondary)

            content()
        }
    }
}
