import SwiftUI

struct RatingDistanceLine: View {
    let rating: Double
    let distance: Double
    let location: String
    
    var body: some View {
        HStack(spacing: Theme.Spacing.small) {
            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .font(.system(size: Theme.Size.iconSmall))
                    .foregroundStyle(Theme.accent)
                Text(String(format: "%.1f", rating))
            }
            
            Text("·")
            
            HStack(spacing: 3) {
                Image(systemName: "location")
                    .font(.system(size: Theme.Size.iconSmall))
                Text(String(format: "%.1f km", distance))
            }
            
            Text("·")
            
            Text(location)
                .lineLimit(1)
        }
        .font(Theme.metadata)
        .foregroundStyle(Theme.textSecondary)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Rating \(String(format: "%.1f", rating)) stars, \(String(format: "%.1f", distance)) kilometers away, \(location)")
    }
}
