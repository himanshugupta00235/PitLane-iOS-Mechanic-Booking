import SwiftUI

struct MultilineTextField: View {
    let placeholder: String
    @Binding var text: String
    var minHeight: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(Theme.body)
                    .foregroundStyle(Theme.textSecondary.opacity(0.6))
                    .padding(.horizontal, Theme.Spacing.medium)
                    .padding(.vertical, Theme.Spacing.medium)
            }
            
            TextEditor(text: $text)
                .font(Theme.body)
                .foregroundStyle(Theme.textPrimary)
                .scrollContentBackground(.hidden)
                .frame(minHeight: minHeight)
                .padding(.horizontal, Theme.Spacing.small)
                .padding(.vertical, Theme.Spacing.base)
        }
        .background(
            RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                .fill(Theme.surface)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Size.buttonRadius)
                .stroke(Theme.divider, lineWidth: 1)
        )
    }
}
