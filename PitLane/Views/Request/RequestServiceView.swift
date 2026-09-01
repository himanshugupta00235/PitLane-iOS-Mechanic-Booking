import SwiftUI

struct RequestServiceView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: RequestServiceViewModel
    let onSubmit: (ServiceRequest) -> Void

    init(mechanic: Mechanic, onSubmit: @escaping (ServiceRequest) -> Void) {
        self._viewModel = State(initialValue: RequestServiceViewModel(mechanic: mechanic))
        self.onSubmit = onSubmit
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.section) {
                    // Garage name header
                    HStack {
                        Image(systemName: "wrench.and.screwdriver")
                            .foregroundStyle(Theme.accent)
                        Text(viewModel.mechanic.name)
                            .font(Theme.garageName)
                            .foregroundStyle(Theme.textPrimary)
                    }

                    LedgerDivider()

                    // Service Selection
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        FormSectionLabel(title: "Select Service")
                        ServiceSelector(
                            services: viewModel.mechanic.services,
                            selectedService: $viewModel.selectedService
                        )
                        if viewModel.showValidation && viewModel.selectedService == nil {
                            Text("Please select a service")
                                .font(Theme.caption)
                                .foregroundStyle(Theme.errorColor)
                        }
                    }

                    // Vehicle Number
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        FormSectionLabel(title: "Vehicle Number")
                        VehicleNumberField(
                            text: $viewModel.vehicleNumber,
                            isValid: viewModel.isVehicleNumberValid,
                            showValidation: viewModel.showValidation
                        )
                    }

                    // Problem Description
                    VStack(alignment: .leading, spacing: Theme.Spacing.small) {
                        FormSectionLabel(title: "Problem Description")
                        MultilineTextField(
                            placeholder: "Describe the issue with your vehicle (min. 10 characters)...",
                            text: $viewModel.problemDescription
                        )
                        if viewModel.showValidation &&
                            !viewModel.problemDescription.isEmpty &&
                            viewModel.problemDescription.trimmingCharacters(in: .whitespacesAndNewlines).count < 10 {
                            Text("Description must be at least 10 characters")
                                .font(Theme.caption)
                                .foregroundStyle(Theme.errorColor)
                        }
                    }

                    // Submit
                    PrimaryButton(
                        title: "Submit Request",
                        isLoading: viewModel.isSubmitting,
                        isDisabled: viewModel.showValidation && !viewModel.isFormValid
                    ) {
                        Task {
                            await viewModel.submit()
                            if let request = viewModel.submittedRequest {
                                onSubmit(request)
                            }
                        }
                    }
                }
                .padding(Theme.Spacing.screen)
            }
            .background(Theme.background)
            .navigationTitle("Request Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Theme.accent)
                }
            }
            .alert("Submission Failed", isPresented: Binding(
                get: { viewModel.submitError != nil },
                set: { if !$0 { viewModel.submitError = nil } }
            )) {
                Button("Retry") {
                    Task { await viewModel.submit() }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(viewModel.submitError ?? "")
            }
        }
    }
}
