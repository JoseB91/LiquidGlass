//
//  MorphTransitionView.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import SwiftUI

struct MorphTransitionView: View {
    @Namespace private var morphNamespace
    private let items = CardItem.samples

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(value: item) {
                            MorphItemRow(item: item, namespace: morphNamespace)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Morph Transition")
            .navigationDestination(for: CardItem.self) { item in
                MorphDetailView(item: item, namespace: morphNamespace)
            }
            .background {
                LinearGradient(
                    colors: [.orange.opacity(0.2), .red.opacity(0.2), .purple.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
        }
    }
}

// MARK: - Item Row (origen de la transición)
struct MorphItemRow: View {
    let item: CardItem
    let namespace: Namespace.ID

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
        HStack(spacing: 16) {
            Image(systemName: item.icon)
                .font(.title2)
                .foregroundStyle(iconColor)
                .frame(width: 44, height: 44)
                .glassEffect(in: .rect(cornerRadius: 12))
                .glassEffectID(item.id, in: namespace)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(in: .rect(cornerRadius: 16))
    }
}

// MARK: - Detail View (destino de la transición)
struct MorphDetailView: View {
    let item: CardItem
    let namespace: Namespace.ID

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
        ScrollView {
            VStack(spacing: 24) {
                // Icono con morph transition
                Image(systemName: item.icon)
                    .font(.system(size: 60))
                    .foregroundStyle(iconColor)
                    .frame(width: 120, height: 120)
                    .glassEffect(in: .rect(cornerRadius: 24))
                    .glassEffectID(item.id, in: namespace)

                // Información
                VStack(spacing: 8) {
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(item.subtitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                // Contenido de ejemplo
                GlassPanel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Detalles")
                            .font(.headline)

                        Text("Este es un ejemplo de vista de detalle con transición morph. El icono de arriba se anima desde la fila de la lista hasta su posición final usando glassEffectID.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }

                GlassPanel {
                    HStack {
                        Label("Favorito", systemImage: "star.fill")
                        Spacer()
                        Toggle("", isOn: .constant(false))
                    }
                }

                GlassPanel {
                    HStack {
                        Label("Compartir", systemImage: "square.and.arrow.up")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                }

                Spacer(minLength: 50)
            }
            .padding()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .background {
            LinearGradient(
                colors: [.orange.opacity(0.2), .red.opacity(0.2), .purple.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MorphTransitionView()
}
