//
//  CardItem.swift
//  LiquidGlass
//
//  Created by José Briones on 18/1/26.
//

import Foundation

struct CardItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let icon: String
    let color: String

    init(id: UUID = UUID(), title: String, subtitle: String, icon: String, color: String = "blue") {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.color = color
    }
}

extension CardItem {
    static let samples: [CardItem] = [
        CardItem(title: "Fotos", subtitle: "1,234 items", icon: "photo.fill", color: "orange"),
        CardItem(title: "Música", subtitle: "456 canciones", icon: "music.note", color: "pink"),
        CardItem(title: "Videos", subtitle: "89 videos", icon: "play.rectangle.fill", color: "purple"),
        CardItem(title: "Documentos", subtitle: "234 archivos", icon: "doc.fill", color: "blue"),
        CardItem(title: "Descargas", subtitle: "12 nuevos", icon: "arrow.down.circle.fill", color: "green"),
        CardItem(title: "Favoritos", subtitle: "67 items", icon: "star.fill", color: "yellow"),
        CardItem(title: "Recientes", subtitle: "Hoy", icon: "clock.fill", color: "gray"),
        CardItem(title: "Compartido", subtitle: "8 personas", icon: "person.2.fill", color: "cyan"),
        CardItem(title: "Archivos", subtitle: "156 items", icon: "folder.fill", color: "blue"),
        CardItem(title: "Notas", subtitle: "42 notas", icon: "note.text", color: "yellow"),
        CardItem(title: "Recordatorios", subtitle: "18 pendientes", icon: "checklist", color: "orange"),
        CardItem(title: "Calendario", subtitle: "3 eventos hoy", icon: "calendar", color: "pink"),
        CardItem(title: "Contactos", subtitle: "892 contactos", icon: "person.crop.circle.fill", color: "green"),
        CardItem(title: "Mensajes", subtitle: "5 sin leer", icon: "message.fill", color: "purple")
    ]
}
