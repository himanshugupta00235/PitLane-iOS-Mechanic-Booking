import SwiftUI

struct FormSectionLabel: View {
    let title: String
    var isRequired: Bool = true
    
    var body: some View {
        HStack(spacing: 2) {
            Text(title.uppercased())
                .font(Theme.sectionLabel)
                .foregroundStyle(Theme.textSecondary)
                .tracking(0.8)
            
            if isRequired {
                Text("*")
                    .font(Theme.sectionLabel)
                    .foregroundStyle(Theme.accent)
            }
        }
    }
}
