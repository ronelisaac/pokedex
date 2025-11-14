//
//  DSLAbels.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct DSTextLabel: View {
    let text: String
    let style: DSTextStyle
    var color: Color = DSColor.textPrimary

    var body: some View {
        Text(text)
            .font(fontForStyle(style))
            .foregroundColor(color)
    }

    private func fontForStyle(_ style: DSTextStyle) -> Font {
        switch style {
        case .largeTitle: return DSTypography.largeTitle
        case .title:      return DSTypography.title
        case .subtitle:   return DSTypography.subtitle
        case .body:       return DSTypography.body
        case .caption:    return DSTypography.caption
        }
    }
}

