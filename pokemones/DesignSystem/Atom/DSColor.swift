//
//  DSColor.swift
//  pokemones
//  Color Tokens
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct DSColor {
    // Base – claros modernos
    static let background = Color(hex: "FFFFFF")   // gris muy claro
    static let surface = Color(hex: "FFFFFF")      // blanco puro para cards
    static let surfaceAlt = Color(hex: "E5E7EB")   // gris claro variante
    static let border = Color.black.opacity(0.1)

    // Texto – oscuros legibles
    static let textPrimary = Color(hex: "111827")
    static let textSecondary = Color(hex: "4B5563")
    static let textMuted = Color(hex: "9CA3AF")

    // Acciones – azules modernos
    static let accent = Color(hex: "2563EB")
    static let accentSoft = Color(hex: "3B82F6")

    static let error = Color(hex: "EF4444")
    static let success = Color(hex: "22C55E")

    // Pokémon Type mapping
    static func pokemonType(_ type: String) -> Color {
        switch type.lowercased() {
        case "grass": return Color(hex: "22C55E")
        case "poison": return Color(hex: "A855F7")
        case "fire": return Color(hex: "F97316")
        case "water": return Color(hex: "0EA5E9")
        case "electric": return Color(hex: "FACC15")
        case "psychic": return Color(hex: "FB7185")
        case "ice": return Color(hex: "7DD3FC")
        case "dragon": return Color(hex: "8B5CF6")
        case "dark": return Color(hex: "374151")
        case "fairy": return Color(hex: "F9A8D4")
        default: return Color(hex: "9CA3AF")
        }
    }
}

extension Color {
    init(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xff) / 255
        let g = Double((rgbValue >> 8) & 0xff) / 255
        let b = Double(rgbValue & 0xff) / 255

        self.init(red: r, green: g, blue: b)
    }
}
