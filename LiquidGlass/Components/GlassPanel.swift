//
//  GlassPanel.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import SwiftUI

struct GlassPanel<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(in: .rect(cornerRadius: 16))
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.orange, .red, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(spacing: 20) {
            GlassPanel {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                    Text("Este es un panel informativo con efecto glass")
                        .font(.body)
                }
            }

            GlassPanel {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Estadísticas")
                        .font(.headline)
                    HStack {
                        Label("1,234", systemImage: "heart.fill")
                        Spacer()
                        Label("567", systemImage: "message.fill")
                        Spacer()
                        Label("89", systemImage: "square.and.arrow.up.fill")
                    }
                    .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
    }
}
