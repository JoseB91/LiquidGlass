//
//  MainTabView.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Cards", systemImage: "rectangle.grid.2x2") {
                GlassCardsView()
            }

            Tab("Morph", systemImage: "arrow.triangle.2.circlepath") {
                MorphTransitionView()
            }
            Tab("Cards", systemImage: "rectangle.grid.2x2") {
                GlassCardsView()
            }

            Tab("Morph", systemImage: "arrow.triangle.2.circlepath") {
                MorphTransitionView()
            }
            Tab("Cards", systemImage: "rectangle.grid.2x2") {
                GlassCardsView()
            }
        }
        .tabBarMinimizeBehavior(.automatic)
    }
}

#Preview {
    MainTabView()
}
