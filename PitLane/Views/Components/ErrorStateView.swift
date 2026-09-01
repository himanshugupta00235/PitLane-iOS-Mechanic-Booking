import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: Theme.Spacing.section) {
            VStack(spacing: Theme.Spacing.medium) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 44))
                    .foregroundStyle(Theme.errorColor)
                
                Text(message)
                    .font(Theme.body)
                    .foregroundStyle(Theme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Theme.Spacing.xlarge)
            }
            
            Button(action: retryAction) {
                HStack(spacing: Theme.Spacing.base) {
                    Image(systemName: "arrow.clockwise")
                    Text("Retry")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Theme.accent)
                .padding(.horizontal, Theme.Spacing.section)
                .padding(.vertical, Theme.Spacing.medium)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                        .stroke(Theme.accent, lineWidth: 1.5)
                )
            }
            .accessibilityLabel("Retry loading")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
