import SwiftUI

struct MechanicLedgerRow: View {
    let mechanic: Mechanic
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            HStack {
                Text(mechanic.name)
                    .font(Theme.garageName)
                    .foregroundStyle(Theme.textPrimary)
                
                Spacer()
                
                StatusStamp(isOpen: mechanic.isOpen)
            }
            
            RatingDistanceLine(
                rating: mechanic.rating,
                distance: mechanic.distance,
                location: mechanic.location
            )
            
            ServiceTagRow(services: mechanic.services, maxVisible: 3)
        }
        .padding(.horizontal, Theme.Spacing.screen)
        .padding(.vertical, Theme.Spacing.medium)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(mechanic.name), \(mechanic.isOpen ? "open" : "closed"), rating \(String(format: "%.1f", mechanic.rating)), \(String(format: "%.1f", mechanic.distance)) kilometers")
        .accessibilityHint("Double tap to view details")
    }
}
