# Plan de Desarrollo - LiquidGlass PoC

## Objetivo
Crear un Proof of Concept (PoC) que demuestre las nuevas capacidades de **Liquid Glass** en iOS 26 / Xcode 26.

---

## Requisitos del Sistema
- **Xcode**: 26.0+
- **iOS Target**: 26.0+
- **Swift**: 6.0+
- **Dispositivo**: iPhone/iPad con iOS 26 beta

---

## Fases de Desarrollo

### Fase 1: Configuración del Proyecto ✅
- [x] Configurar deployment target a iOS 26
- [x] Verificar que el proyecto compile correctamente en Xcode 26
- [x] Crear estructura de carpetas del proyecto

**Estructura implementada:**
```
LiquidGlass/
├── LiquidGlassApp.swift
├── Views/
│   ├── MainTabView.swift
│   ├── GlassCardsView.swift
│   └── MorphTransitionView.swift
├── Components/
│   ├── GlassCard.swift
│   └── GlassPanel.swift
├── Models/
│   └── CardItem.swift
└── Utilities/
    └── PerformanceMonitor.swift
```

---

### Fase 2: Pantalla de Glass Cards/Paneles ✅
**Archivos:** `GlassCardsView.swift`, `Components/GlassCard.swift`, `Components/GlassPanel.swift`

#### Tareas:
- [x] Crear vista principal con ScrollView
- [x] Implementar componente `GlassCard` reutilizable con `.glassEffect()`
- [x] Crear grid de cards con diferentes tamaños (small, medium, large)
- [x] Agregar contenido variado (texto, iconos)
- [x] Crear `GlassPanel` genérico para contenido flexible

#### Implementación:
- `GlassCard`: Componente con 3 tamaños (small: 100pt, medium: 140pt, large: 200pt)
- `GlassPanel`: Componente genérico con ViewBuilder para contenido personalizado
- `GlassCardsView`: Layout con header grande + grid 2 columnas + cards pequeñas

#### Variantes implementadas:
- Glass effect básico (`.glassEffect()`)
- Cards de diferentes tamaños
- Paneles con contenido personalizable

---

### Fase 3: Pantalla de Transición Morph ✅
**Archivo:** `MorphTransitionView.swift`

#### Tareas:
- [x] Crear vista con lista de items (`MorphItemRow`)
- [x] Implementar vista de detalle (`MorphDetailView`)
- [x] Configurar `glassEffectID` en elementos origen
- [x] Configurar `GlassEffectContainer` en vista destino
- [x] Implementar navegación con transición morph animada

#### Implementación:
- `MorphItemRow`: Fila con icono glass que tiene `.glassEffectID(item.id)`
- `MorphDetailView`: Vista de detalle con `GlassEffectContainer` que envuelve el icono destino
- Navegación con `NavigationLink(value:)` y `.navigationDestination`
- El icono se anima desde 44x44 en la lista hasta 120x120 en el detalle

---

### Fase 4: Tab Bar con Minimize on Scroll ✅
**Archivo:** `MainTabView.swift`

#### Tareas:
- [x] Crear TabView principal con 2+ tabs
- [x] Implementar `.tabBarMinimizeBehavior(.onScrollDown)`
- [x] Verificar comportamiento en ambas pantallas con scroll
- [x] Ajustar contenido para demostrar el efecto de minimización

#### Código de referencia:
```swift
struct MainTabView: View {
    var body: some View {
        TabView {
            GlassCardsView()
                .tabItem {
                    Label("Cards", systemImage: "rectangle.grid.2x2")
                }

            MorphTransitionView()
                .tabItem {
                    Label("Morph", systemImage: "arrow.triangle.2.circlepath")
                }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}
```

---

### Fase 5: Testing de Accesibilidad
**Configuraciones a probar en Settings > Accessibility:**

#### Reduce Transparency
- [ ] Activar "Reduce Transparency" en configuración del dispositivo
- [ ] Verificar que las vistas glass se adaptan correctamente
- [ ] Documentar comportamiento visual (fallback a opacidad sólida)
- [ ] Capturar screenshots antes/después

#### Increase Contrast
- [ ] Activar "Increase Contrast" en configuración del dispositivo
- [ ] Verificar legibilidad del contenido sobre glass
- [ ] Verificar bordes y separadores
- [ ] Documentar ajustes automáticos del sistema

#### Dynamic Type
- [ ] Probar con tamaños de texto: XS, S, M, L, XL, XXL, XXXL
- [ ] Verificar que las cards escalan correctamente
- [ ] Verificar que el texto no se trunca incorrectamente
- [ ] Probar con Accessibility sizes activados

#### Checklist de accesibilidad:
| Configuración | Estado | Notas |
|---------------|--------|-------|
| Reduce Transparency OFF | ⬜ | Comportamiento base |
| Reduce Transparency ON | ⬜ | |
| Increase Contrast OFF | ⬜ | Comportamiento base |
| Increase Contrast ON | ⬜ | |
| Dynamic Type - Default | ⬜ | |
| Dynamic Type - XL | ⬜ | |
| Dynamic Type - Accessibility XXL | ⬜ | |

---

### Fase 6: Medición de Rendimiento (FPS / Costo Visual)

#### Herramientas:
- Instruments (Core Animation / GPU profiling)
- CADisplayLink para medición en código
- Debug > View Debugging > Rendering en Xcode

#### Tareas:
- [ ] Implementar `PerformanceMonitor` para medir FPS en tiempo real
- [ ] Medir FPS base sin efectos glass
- [ ] Medir FPS con glass effects activados
- [ ] Identificar número de capas de vidrio renderizadas
- [ ] Probar reducción de capas y medir impacto

#### Código de referencia - Monitor de FPS:
```swift
class PerformanceMonitor: ObservableObject {
    @Published var fps: Double = 0
    private var displayLink: CADisplayLink?
    private var lastTimestamp: CFTimeInterval = 0
    private var frameCount: Int = 0

    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc private func update(link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }

        frameCount += 1
        let elapsed = link.timestamp - lastTimestamp

        if elapsed >= 1.0 {
            fps = Double(frameCount) / elapsed
            frameCount = 0
            lastTimestamp = link.timestamp
        }
    }

    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
```

#### Métricas a capturar:
| Escenario | FPS | GPU % | Capas Glass | Notas |
|-----------|-----|-------|-------------|-------|
| Sin glass effects | ⬜ | ⬜ | 0 | Baseline |
| 1 glass card visible | ⬜ | ⬜ | 1 | |
| 4 glass cards visibles | ⬜ | ⬜ | 4 | |
| 8+ glass cards (scroll) | ⬜ | ⬜ | 8+ | |
| Transición morph | ⬜ | ⬜ | 2 | Durante animación |
| Reduce Transparency ON | ⬜ | ⬜ | 0 | Comparar rendimiento |

#### Optimizaciones a probar:
- [ ] Reducir número de capas glass simultáneas
- [ ] Usar `drawingGroup()` para rasterizar contenido complejo
- [ ] Implementar lazy loading de glass effects fuera de pantalla
- [ ] Comparar rendimiento en dispositivos de diferentes generaciones

---

## Entregables

1. **App funcional** con las 2 pantallas implementadas
2. **Documento de resultados** con:
   - Screenshots de cada configuración de accesibilidad
   - Tabla de métricas de rendimiento
   - Recomendaciones de optimización
3. **Video demo** mostrando:
   - Navegación entre tabs con minimize behavior
   - Scroll en pantalla de cards
   - Transición morph entre vistas
   - Comportamiento con Reduce Transparency

---

## Timeline Sugerido

| Fase | Descripción |
|------|-------------|
| 1 | Configuración del proyecto |
| 2 | Pantalla Glass Cards |
| 3 | Pantalla Morph Transition |
| 4 | Tab Bar con minimize |
| 5 | Testing de accesibilidad |
| 6 | Medición de rendimiento |

---

## Notas Técnicas

### Consideraciones de iOS 26:
- Los glass effects son nativos del sistema y se adaptan automáticamente a las preferencias de accesibilidad
- `glassEffectID` requiere un `Namespace` para coordinar las transiciones
- El `tabBarMinimizeBehavior` funciona mejor con ScrollView que con List

### Compatibilidad:
- Este PoC es exclusivo para iOS 26+
- No se requiere fallback para versiones anteriores (es un PoC)
- Probar en dispositivo físico para métricas de rendimiento precisas

---

## Referencias
- [WWDC25 - What's new in SwiftUI](https://developer.apple.com/videos/wwdc2025/)
- [Human Interface Guidelines - Liquid Glass](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation - glassEffect](https://developer.apple.com/documentation/swiftui/)
