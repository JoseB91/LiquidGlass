//
//  GlassCardsView.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import SwiftUI

struct GlassCardsView: View {
    private let items = CardItem.samples

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Header card grande
                    GlassCard(item: items[0], size: .large)

                    // Grid de cards medianas
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(items.dropFirst().prefix(4)) { item in
                            GlassCard(item: item, size: .medium)
                        }
                    }

                    // Cards pequeñas en fila
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(items.suffix(2)) { item in
                            GlassCard(item: item, size: .small)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Glass Cards")
            .background {
                LinearGradient(
                    colors: [.blue.opacity(0.3), .purple.opacity(0.3), .pink.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    GlassCardsView()
}
