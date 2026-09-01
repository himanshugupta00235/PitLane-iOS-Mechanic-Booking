import SwiftUI

struct ServiceSelector: View {
    let services: [String]
    @Binding var selectedService: String?
    
    var body: some View {
        FlowLayout(spacing: Theme.Spacing.small) {
            ForEach(services, id: \.self) { service in
                ServiceOption(
                    text: service,
                    isSelected: selectedService == service
                ) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        selectedService = service
                    }
                }
            }
        }
    }
}

private struct ServiceOption: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 14))
                Text(text)
                    .font(Theme.body)
            }
            .foregroundStyle(isSelected ? Theme.accent : Theme.textPrimary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                    .fill(isSelected ? Theme.accent.opacity(0.1) : Theme.surface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                    .stroke(isSelected ? Theme.accent : Theme.divider, lineWidth: 1)
            )
        }
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
        .accessibilityLabel("\(text) service")
    }
}
