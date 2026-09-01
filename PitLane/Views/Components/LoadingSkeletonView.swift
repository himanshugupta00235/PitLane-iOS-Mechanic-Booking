import SwiftUI

struct LoadingSkeletonView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3, id: \.self) { index in
                SkeletonRow()
                if index < 2 {
                    LedgerDivider()
                }
            }
        }
        .onAppear { isAnimating = true }
    }
}

private struct SkeletonRow: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.small) {
            HStack {
                SkeletonBlock(width: 180, height: 18)
                Spacer()
                SkeletonBlock(width: 52, height: 20)
            }
            
            SkeletonBlock(width: 220, height: 14)
            
            HStack(spacing: Theme.Spacing.small) {
                SkeletonBlock(width: 70, height: 24)
                SkeletonBlock(width: 60, height: 24)
                SkeletonBlock(width: 55, height: 24)
            }
        }
        .padding(.horizontal, Theme.Spacing.screen)
        .padding(.vertical, Theme.Spacing.medium)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.2)
                .repeatForever(autoreverses: true)
            ) {
                isAnimating = true
            }
        }
    }
}

private struct SkeletonBlock: View {
    let width: CGFloat
    let height: CGFloat
    @State private var opacity: Double = 0.3
    
    var body: some View {
        RoundedRectangle(cornerRadius: Theme.Size.stampRadius)
            .fill(Theme.divider)
            .frame(width: width, height: height)
            .opacity(opacity)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.2)
                    .repeatForever(autoreverses: true)
                ) {
                    opacity = 0.7
                }
            }
    }
}
