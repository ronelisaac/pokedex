//
//  DSText.swift
//  pokemones
//  Typography
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct DSTypography {
    static let largeTitle = Font.system(size: 32, weight: .bold, design: .rounded)
    static let title = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let subtitle = Font.system(size: 18, weight: .medium, design: .rounded)
    static let body = Font.system(size: 16, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 13, weight: .regular, design: .rounded)
}

enum DSTextStyle {
    case largeTitle
    case title
    case subtitle
    case body
    case caption
}
