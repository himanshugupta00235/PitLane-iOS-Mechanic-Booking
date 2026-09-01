import SwiftUI

struct LedgerDivider: View {
    var body: some View {
        Rectangle()
            .fill(Theme.divider)
            .frame(height: Theme.Size.dividerHeight)
    }
}
