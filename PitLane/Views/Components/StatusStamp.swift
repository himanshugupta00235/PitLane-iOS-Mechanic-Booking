import SwiftUI

struct StatusStamp: View {
    let isOpen: Bool
    
    private var text: String {
        isOpen ? "OPEN" : "CLOSED"
    }
    
    private var color: Color {
        isOpen ? Theme.openColor : Theme.closedColor
    }
    
    var body: some View {
        Text(text)
            .font(Theme.stamp)
            .tracking(1.2)
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Size.stampRadius)
                    .stroke(color, lineWidth: Theme.Size.stampBorder)
            )
            .accessibilityLabel(isOpen ? "Currently open" : "Currently closed")
    }
}
