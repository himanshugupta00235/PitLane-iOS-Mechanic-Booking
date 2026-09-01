import SwiftUI

struct VehicleNumberField: View {
    @Binding var text: String
    var isValid: Bool
    var showValidation: Bool
    
    // Indian vehicle plate regex: e.g. HR26AB1234, DL01C1234, KA05MR4567
    static let validationPattern = "^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{4}$"
    
    static func validate(_ input: String) -> Bool {
        let trimmed = input.trimmingCharacters(in: .whitespaces).uppercased()
        guard !trimmed.isEmpty else { return false }
        return trimmed.range(of: validationPattern, options: .regularExpression) != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.base) {
            TextField("e.g. HR26AB1234", text: $text)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .padding(Theme.Spacing.medium)
                .background(
                    RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                        .fill(Theme.surface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                        .stroke(borderColor, lineWidth: 1)
                )
                .onChange(of: text) { _, newValue in
                    text = newValue.uppercased()
                }
            
            if showValidation && !text.isEmpty && !isValid {
                Text("Enter a valid Indian vehicle number (e.g. HR26AB1234)")
                    .font(Theme.caption)
                    .foregroundStyle(Theme.errorColor)
            }
        }
    }
    
    private var borderColor: Color {
        if showValidation && !text.isEmpty && !isValid {
            return Theme.errorColor
        }
        return Theme.divider
    }
}
