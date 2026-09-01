import SwiftUI

struct ServiceTagRow: View {
    let services: [String]
    var maxVisible: Int = 3
    var showAll: Bool = false
    
    private var displayedServices: [String] {
        if showAll { return services }
        return Array(services.prefix(maxVisible))
    }
    
    private var overflowCount: Int {
        guard !showAll else { return 0 }
        return max(0, services.count - maxVisible)
    }
    
    var body: some View {
        FlowLayout(spacing: Theme.Spacing.small) {
            ForEach(displayedServices, id: \.self) { service in
                ServiceTag(text: service)
            }
            if overflowCount > 0 {
                Text("+\(overflowCount) more")
                    .font(Theme.caption)
                    .foregroundStyle(Theme.textSecondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Services: \(services.joined(separator: ", "))")
    }
}

private struct ServiceTag: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(Theme.caption)
            .foregroundStyle(Theme.textPrimary)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: Theme.Size.stampRadius)
                    .fill(Theme.divider.opacity(0.5))
            )
    }
}

// MARK: - FlowLayout for wrapping tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(result.sizes[index])
            )
        }
    }
    
    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> ArrangementResult {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            sizes.append(size)
            
            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            
            positions.append(CGPoint(x: currentX, y: currentY))
            rowHeight = max(rowHeight, size.height)
            currentX += size.width + spacing
        }
        
        let totalHeight = currentY + rowHeight
        return ArrangementResult(
            size: CGSize(width: maxWidth, height: totalHeight),
            positions: positions,
            sizes: sizes
        )
    }
    
    private struct ArrangementResult {
        let size: CGSize
        let positions: [CGPoint]
        let sizes: [CGSize]
    }
}
