//
//  GlassCard.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import SwiftUI

struct GlassCard: View {
    let item: CardItem
    var size: CardSize = .medium

    enum CardSize {
        case small, medium, large

        var height: CGFloat {
            switch self {
            case .small: return 100
            case .medium: return 140
            case .large: return 200
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .small: return 28
            case .medium: return 36
            case .large: return 48
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small: return 16
            case .medium: return 20
            case .large: return 24
            }
        }
    }

    private var iconColor: Color {
        switch item.color {
        case "orange": return .orange
        case "pink": return .pink
        case "purple": return .purple
        case "blue": return .blue
        case "green": return .green
        case "yellow": return .yellow
        case "gray": return .gray
        case "cyan": return .cyan
        default: return .blue
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: item.icon)
                .font(.system(size: size.iconSize, weight: .semibold))
                .foregroundStyle(iconColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)

                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: size.height)
        .glassEffect(in: .rect(cornerRadius: size.cornerRadius))
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.blue, .purple, .pink],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(spacing: 16) {
            GlassCard(item: CardItem.samples[0], size: .large)
            GlassCard(item: CardItem.samples[1], size: .medium)
            GlassCard(item: CardItem.samples[2], size: .small)
        }
        .padding()
    }
}
