import SwiftUI

struct ConfirmationView: View {
    let serviceRequest: ServiceRequest
    @Binding var navigationPath: NavigationPath
    @State private var showCheckmark = false

    var body: some View {
        VStack(spacing: Theme.Spacing.section) {
            Spacer()

            // Checkmark
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(Theme.openColor)
                .scaleEffect(showCheckmark ? 1.0 : 0.5)
                .opacity(showCheckmark ? 1.0 : 0.0)

            // Success message
            VStack(spacing: Theme.Spacing.small) {
                Text("Service Request Submitted")
                    .font(Theme.screenTitle)
                    .foregroundStyle(Theme.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Your request has been sent successfully.")
                    .font(Theme.body)
                    .foregroundStyle(Theme.textSecondary)
                    .multilineTextAlignment(.center)
            }

            // Reference ID
            Text(serviceRequest.referenceId)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundStyle(Theme.accent)

            // Summary
            VStack(spacing: Theme.Spacing.small) {
                LedgerDivider()

                VStack(spacing: Theme.Spacing.base) {
                    SummaryRow(label: "Garage", value: serviceRequest.mechanicName)
                    SummaryRow(label: "Service", value: serviceRequest.service)
                    SummaryRow(label: "Vehicle", value: serviceRequest.vehicleNumber)
                }
                .padding(.vertical, Theme.Spacing.medium)

                LedgerDivider()
            }
            .padding(.horizontal, Theme.Spacing.screen)

            Spacer()

            // Back to Garages
            PrimaryButton(title: "Back to Garages") {
                navigationPath = NavigationPath()
            }
            .padding(.horizontal, Theme.Spacing.screen)
            .padding(.bottom, Theme.Spacing.section)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.background)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                showCheckmark = true
            }
        }
    }
}

private struct SummaryRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(Theme.metadata)
                .foregroundStyle(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(Theme.body)
                .foregroundStyle(Theme.textPrimary)
        }
    }
}
