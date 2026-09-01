import SwiftUI

@MainActor
@Observable
final class RequestServiceViewModel {
    let mechanic: Mechanic

    var selectedService: String?
    var vehicleNumber: String = ""
    var problemDescription: String = ""
    var isSubmitting: Bool = false
    var showValidation: Bool = false
    var submitError: String?
    var submittedRequest: ServiceRequest?

    var isVehicleNumberValid: Bool {
        VehicleNumberField.validate(vehicleNumber)
    }

    var isFormValid: Bool {
        selectedService != nil &&
        isVehicleNumberValid &&
        !problemDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        problemDescription.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10
    }

    init(mechanic: Mechanic) {
        self.mechanic = mechanic
    }

    func submit() async {
        showValidation = true
        guard isFormValid else { return }

        isSubmitting = true
        submitError = nil

        do {
            // Simulate async network POST with 1.2s delay
            try await Task.sleep(nanoseconds: 1_200_000_000)

            let request = ServiceRequest(
                mechanicId: mechanic.id,
                mechanicName: mechanic.name,
                service: selectedService ?? "",
                vehicleNumber: vehicleNumber.trimmingCharacters(in: .whitespaces).uppercased(),
                problemDescription: problemDescription.trimmingCharacters(in: .whitespacesAndNewlines),
                referenceId: ServiceRequest.generateReferenceId(),
                timestamp: Date()
            )

            submittedRequest = request
        } catch {
            submitError = "Failed to submit request. Please try again."
        }

        isSubmitting = false
    }
}
